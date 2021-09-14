using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data;

public partial class ProductDetails : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if(!this.IsPostBack)
            {
                GetProductDetails();
            }

        }
        catch(Exception ex)
        {

        }
    }
    private void GetProductDetails()
    {
        try
        {
            DataSet ds = objAdm.getProductDetails(Request.QueryString ["ID"].ToString ());
            LVProducts.DataSource = ds;
            LVProducts.DataBind();
        }
        catch(Exception ex)
        {

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
}