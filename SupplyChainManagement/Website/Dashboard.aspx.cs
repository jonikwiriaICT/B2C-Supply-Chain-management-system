using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;

public partial class Dashboard : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {
                CountData();
            }
        }
        catch(Exception ex)
        {

        }
    }
    protected void Page_Init(object sender, EventArgs e)
    {

    }
    protected void Page_UnLoad(object sender, EventArgs e)
    {
        try
        {
            objAdm.CloseConnection();
        }
        catch(Exception ex)
        {

        }
    }

    private void CountData()
    {
        try
        {
            lblManufacturerSales.Text = objAdm.CountData("qry_manufacturer_sales");
            lblCancelledManufacturerSales.Text = objAdm.CountData("qry_manufacturer_cancelled_sales");
            lblRetailerSales.Text = objAdm.CountData("qry_retailer_sales");
            lblRetailerCancelledSales.Text = objAdm.CountData("qry_retailer_cancelled_sales");
        }
        catch(Exception ex)
        {

        }
    }
}