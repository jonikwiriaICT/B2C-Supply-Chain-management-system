using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;


public partial class PaymentSuccess : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
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
    public string RetailerID()
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
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_UnLoad(object sender, EventArgs e)
    {
        try
        {

        }
        catch(Exception ex)
        {

        }
    }
    protected void Page_Init(object sender, EventArgs e)
    {

    }
}