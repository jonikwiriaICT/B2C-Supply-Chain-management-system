using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net;
using System.Net.Mail;

public partial class ConsumerCheckOut : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    public string RetailerID = string.Empty;
    public string ManufacturerID = string.Empty;
    public string PurchaseTypeID = string.Empty;
    public string WareHouse = string.Empty;
    public string productID = string.Empty;
    public string remark = string.Empty;
    public string Email = string.Empty;
    public string TelephoneNo = string.Empty;
    Dictionary<string, string> dictionaryCart;
    DataTable dtblProducts;
    DataTable dtblCart;
    public int totalQuantity = 0;
    public double totalAmount = 0;
    public int tot;
    public int OrderItemNo;

    public object RecID { get; private set; }

    public string Administrator()
    {
        try
        {
            string username = ((SupplyChainMaster)this.Master).Retailer;
            return username;
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    public string retailer()
    {
        try
        {
            string username = ((SupplyChainMaster)this.Master).RetailerID;
            return username;
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    //private void checkAll()
    //{
    //    try
    //    {
    //        foreach (GridViewRow grow in GVCart.Rows)
    //        {
    //            CheckBox chkVerified = (CheckBox)grow.FindControl("chkcheck");
    //            if (chkVerified.Checked == false)
    //            {
    //                chkVerified.Checked = true;
    //                lblCheck.Text = "Uncheck";
    //            }

    //        }

    //    }
    //    catch(Exception ex)
    //    {

    //    }
    //}
    protected void Page_Load(object sender, EventArgs e)
    {


        var cookieCart = Request.Cookies["CookieCart"];

        if (cookieCart != null)
        {
            dictionaryCart = objAdm.ToDictionary(cookieCart.Value);

            CreateDataTableCart();

            if (dtblCart.Rows.Count > 0)
            {
                GVCart.DataSource = dtblCart;
                GVCart.DataBind();

            }
        }





    }
    protected void Page_UnLoad(object sender, EventArgs e)
    {
        try
        {
            objAdm.CloseConnection();
        }
        catch (Exception ex)
        {

        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    private void PopulateData()
    {
        dtblProducts = objAdm.PopulateViewCart("GetTopRetailerProduct");
    }
    private void CreateDataTableCart()
    {
        PopulateData();
        dtblCart = new DataTable();
        dtblCart.Columns.Add("ProductID");
        dtblCart.Columns.Add("ProductName");
        dtblCart.Columns.Add("RetailerID");
        dtblCart.Columns.Add("SellingPrice");
        dtblCart.Columns.Add("RetailerName");
        dtblCart.Columns.Add("softwarequantity");
        dtblCart.Columns.Add("softwareTotalAmount");
        dtblCart.Columns.Add("ProductProfile");
        foreach (KeyValuePair<string, string> item in dictionaryCart)
        {
            DataRow[] selectedRow = dtblProducts.Select("ProductID = " + item.Key);
            DataRow row = dtblCart.NewRow();
            row["ProductID"] = int.Parse(item.Key);
            row["ProductName"] = selectedRow[0]["ProductName"];
            row["RetailerID"] = selectedRow[0]["RetailerID"];
            row["SellingPrice"] = selectedRow[0]["SellingPrice"];
            row["RetailerName"] = selectedRow[0]["RetailerName"];
            row["softwarequantity"] = item.Value;
            row["softwareTotalAmount"] = double.Parse(row["SellingPrice"].ToString()) * int.Parse(item.Value);
            totalAmount += double.Parse(row["SellingPrice"].ToString()) * int.Parse(item.Value);
            Session["Consumertotal"] = totalAmount;
            row["ProductProfile"] = selectedRow[0]["ProductProfile"];
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ConnectionString;
            con.Open();
            using (SqlCommand newCmd = new SqlCommand())
            {
                newCmd.Connection = con;
                newCmd.CommandType = CommandType.Text;
                newCmd.CommandText = "insert into tbl_transaction_stock(order_id, consumer_id, retailer_id, product_id, quantity, price,flag_on) values ('" + Session["order"].ToString() + "','" + Session["ConsumerID"].ToString() + "','" + row["RetailerID"].ToString() + "','" + row["ProductID"].ToString() + "','" + row["softwarequantity"].ToString() + "','" + row["SellingPrice"].ToString() + "','1' )";
                newCmd.ExecuteNonQuery();
            }
            using (SqlCommand newCmd = new SqlCommand())
            {
                newCmd.Connection = con;
                newCmd.CommandType = CommandType.Text;
                newCmd.CommandText = "insert into tbl_shipment(order_id,shipment_name, consumer_id, product_id, quantity,product_address, flag_on) values('" + Session["order"].ToString() + "','SINIDHLService','" + Session["ConsumerID"].ToString() + "','" + row["ProductID"].ToString() + "','" + row["softwarequantity"].ToString() + "','Bwari Abuja Opposite Veritas University.','1')";
                newCmd.ExecuteNonQuery();
            }
            con.Close();
            dtblCart.Rows.Add(row);

        }
        Response.Redirect("Consumer-Payment-Success");

    }
}