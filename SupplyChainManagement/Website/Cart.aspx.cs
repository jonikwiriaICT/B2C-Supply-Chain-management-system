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

public partial class Cart : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    Dictionary<string, string> dictionaryCart;
    DataTable dtblProducts;
    DataTable dtblCart;
    public int totalQuantity = 0;
    public double totalAmount = 0;
    private void GetWareHouse()
    {
        try
        {
            DataSet ds = objAdm.GetWarehouse (RetailerID());
            warehouse .DataSource = ds;
            warehouse.DataValueField = "Code";
            warehouse.DataTextField = "Desc";
            warehouse.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    private void GetPurchaseType()
    {
        try
        {
            DataSet ds = objAdm.GetPurchaseType ();
            PurchaseType .DataSource = ds;
            PurchaseType.DataValueField = "Code";
            PurchaseType.DataTextField = "Desc";
            PurchaseType.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    public string Administrator()
    {
        try
        {
            string username = ((SupplyChainMaster)this.Master).Retailer ;
            return username;
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    public string RetailerID()
    {
        try
        {
            string username = ((SupplyChainMaster)this.Master).RetailerID ;
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
            if(Administrator() == "1")
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
                GetWareHouse();
                GetPurchaseType();
                GetWareHouseAndPurchaseType();
                Session["Email"] = getRetailerEmail();
                Session["Telephone"] = getTelephoneNo();
            }
            else
            {
                Response.Redirect("en");
            }
        }
        catch (Exception ex)
        {

        }
    }
    private void PopulateData()
    {
        dtblProducts = objAdm.PopulateViewCart("GetTopProduct");


    }
    private void CreateDataTableCart()
    {

        PopulateData();
        dtblCart = new DataTable();
        dtblCart.Columns.Add("RecID");
        dtblCart.Columns.Add("ProductName");
        dtblCart.Columns.Add("ManufacturerID");
        dtblCart.Columns.Add("BuyingPrice");
        dtblCart.Columns.Add("ManufacturerName");
        dtblCart.Columns.Add("softwarequantity");
        dtblCart.Columns.Add("softwareTotalAmount");
        dtblCart.Columns.Add("ProductProfile");
        foreach (KeyValuePair<string, string> item in dictionaryCart)
        {
            DataRow[] selectedRow = dtblProducts.Select("RecID = " + item.Key);
            DataRow row = dtblCart.NewRow();
            row["RecID"] = int.Parse(item.Key);
            row["ProductName"] = selectedRow[0]["ProductName"];
            row["ManufacturerID"] = selectedRow[0]["ManufacturerID"];
            row["BuyingPrice"] = selectedRow[0]["BuyingPrice"];
            row["ManufacturerName"] = selectedRow[0]["ManufacturerName"];
            row["softwarequantity"] = item.Value;
            row["softwareTotalAmount"] = double.Parse(row["BuyingPrice"].ToString()) * int.Parse(item.Value);
            totalAmount += double.Parse(row["BuyingPrice"].ToString()) * int.Parse(item.Value);
            Session["total"] = totalAmount;
            row["ProductProfile"] = selectedRow[0]["ProductProfile"];
            dtblCart.Rows.Add(row);
        }
        if (totalAmount == 0)
        {
            idTotal.Visible = false;
            Response.Redirect("Empty-Cart");
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
                Response.Redirect("Cart");
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
    private string getRetailerEmail()
    {
        if (objAdm.getRetailerEmail(Session["RetailerID"].ToString()) == true)
        {
            return objAdm.Email;
        }
        return "Null";
    }
    private string getTelephoneNo()
    {
        if (objAdm.getRetailerEmail(Session["RetailerID"].ToString()) == true)
        {
            return objAdm.telephone_no;
        }
        return "Null";
    }

    protected void NavigateToPayOut(object sender, EventArgs e)
    {
        try
        {
          
            Response.Redirect("Check");
           
        }
        catch (Exception ex)
        {

        }
    }

    private void GetWareHouseAndPurchaseType()
    {
        try
        {
            Session["PurchaseType"] = PurchaseType.SelectedValue;
            Session["Warehouse"] = warehouse.SelectedValue;

        }
        catch(Exception ex)
        {

        }
    }

   
}