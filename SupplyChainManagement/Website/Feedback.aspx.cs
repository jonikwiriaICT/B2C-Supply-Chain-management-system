using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data;

public partial class Feedback : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    public string ConsumerName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {
                if (Request.QueryString["ID"] == "0")
                {
                    Response.Redirect("Consumer-Login");
                }
                else
                {

                    ConsumerName = "Welcome to Sini B2C Electronic Supply Chain Management System." + "  " + Session["ConsumerName"] + "," + " " + "Please we will like you to give feedback on our service. This will enable the programmer to improve on my intelligence.";
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void NavigateClicked(object sender, EventArgs e)
    {
        try
        {
            if (sender.Equals(lnkGoB))
            {
                Response.Redirect("Chat-Bot");
            }
        }
        catch (Exception ex)
        {

        }
    }
    private void getMessageLog()
    {
        try
        {
            DataSet ds = objAdm.getMessage();
            dtMessageLog.DataSource = ds;

            dtMessageLog.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void SignIn(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("Index");
        }
        catch (Exception ex)
        {

        }
    }
}