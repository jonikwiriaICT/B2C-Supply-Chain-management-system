using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using System.Data.SqlClient;
using SupplyChainLibrary;


using System.Web.Script.Services;
using System.Configuration;

public partial class ConsumerCart : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    Dictionary<string, string> dictionaryCart;
    DataTable dtblProducts;
    DataTable dtblCart;
    public int totalQuantity = 0;
    public double totalAmount = 0;
  
    public string Administrator()
    {
        try
        {
            string username = ((ClientMaster)this.Master).ConsumerID;
            return username;
        }
        catch (Exception ex)
        {
            return null;
        }
    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
        catch (Exception ex)
        {

        }
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
            HttpContext.Current.Session["ConsumerAmount"] = totalAmount;
            row["ProductProfile"] = selectedRow[0]["ProductProfile"];
            dtblCart.Rows.Add(row);
        }
        if (totalAmount == 0)
        {
            idTotal.Visible = false;
            Response.Redirect("Consumer-Empty-Cart");
        }
    }

    protected void GVCart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Remove From Cart":
                string itemID = e.CommandArgument.ToString();
                var cookieCart = Request.Cookies["CookieCart"];
                cookieCart.Value = objAdm.Remove(itemID, cookieCart.Value);
                Response.Cookies["CookieCart"].Value = cookieCart.Value;
                Response.Redirect("Consumer-Cart");
                break;
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
   

    protected void NavigateToPayOut(object sender, EventArgs e)
    {
        try
        {
            
            
         
            Response.Redirect("Client-Pay");

        }
        catch (Exception ex)
        {

        }
    }


}