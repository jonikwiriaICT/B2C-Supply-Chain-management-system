using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel : _Database
    {
        public string ProductPrice = string.Empty;
        public List<ProductClass> CommentNews(string text)
        {
            List<ProductClass> objmenu = new List<ProductClass>();
            DataTable _objdt = new DataTable();
            string querystring = "SELECT  TOP 1  t.RetailerName as [RetailerName], t.ProductID as [ProductID], t.ProductName as [ProductName],  t.ProductProfile as [ProductProfile], p.selling_price as [SellingPrice], fms.score, SOUNDEX([ProductName]) AS SoundexCode from qry_stock_tran t join tbl_product p on p.product_id = t.ProductID CROSS APPLY(select dbo.FuzzyMatchString('" + text + "', [ProductName]) AS score) AS fms ORDER by fms.score desc";
            SqlConnection _objcon = new SqlConnection(connectionstring);
            SqlDataAdapter _objda =
                new SqlDataAdapter(querystring, _objcon);
            _objcon.Open();
            _objda.Fill(_objdt);
            if (_objdt.Rows.Count > 0)
            {
                for (int i = 0; i < _objdt.Rows.Count; i++)
                {
                    objmenu.Add(new ProductClass { RetailerName  = _objdt.Rows[i]["RetailerName"].ToString(), ProductID = _objdt.Rows[i]["ProductID"].ToString(), ProductName = _objdt.Rows[i]["ProductName"].ToString(), ProductProfile = _objdt.Rows[i]["ProductProfile"].ToString(), SellingPrice  = _objdt.Rows[i]["SellingPrice"].ToString() });
                }
            }
            return objmenu;
        }

       
        public bool  CancelProduct(string text)
        {
            try
            {
                string sPasswordDB = string.Empty;
                DataSet ds = new DataSet();
                string sSQL = "SELECT * FROM tbl_transaction_stock WHERE order_id ='" + text + "' ";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    return false;
                  
                }


                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = "No Login Connection.";
                return false;
            }
        }

        public string GetProduct(string text)
        {
            StringBuilder objstr = new StringBuilder();
            List<ProductClass> objpmenu = new List<ProductClass>();
            objpmenu = CommentNews(text );
            foreach (ProductClass _pitem in objpmenu)
            {
                HttpContext.Current.Session["ConsumerAmount"] = _pitem.SellingPrice;
                objstr.Append("<div class='panel'><div class='panel-body'><section class='product-area li-laptop-product pt-60 pb-45'><div class='container'><div class='row'><div class='col-lg-12'><div class='shop-products-wrapper'><div class='tab-content'><div id='grid-view' class='tab-pane fade active show' role='tabpanel'><div class='product-area shop-product-area'><div class='row'><div class='col-lg-3 col-md-3 col-sm-3 mt-40'><div class='single-product-wrap'><div class='product-image'><a href='#'><img src='" + _pitem .ProductProfile + "' style='width:20em; height:20em' runat ='server'  alt='Li's Product Image'/></a></div><div class='product_desc'><div class='product_desc_info'><div class='product-review'><h5 class='manufacturer'><a href='#'>" + _pitem .RetailerName  + "</a></h5></div><h4><a class='product_name' href='#'>" + _pitem .ProductName + "</a></h4><div class='price-box'><span class='new-price'>" + _pitem .SellingPrice  + "</span></div></div><div class='add-actions'><ul class='add-actions-link'><li class='add-cart active'><a href='Client-Pay' class='add-to-cart'><i class='fa fa-paypal'></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>");
            }
            return objstr.ToString();
        }
    }
    public class ProductClass
    {
        public string RetailerName { get; set; }
        public string ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductProfile { get; set; }
        public string SellingPrice { get; set; }


    }
}
