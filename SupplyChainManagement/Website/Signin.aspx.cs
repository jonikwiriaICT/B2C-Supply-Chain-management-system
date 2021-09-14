using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;


public partial class _Default : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {

            }
        }
        catch (Exception ex)
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
    public enum MsgType
    {
        Error = 0,
        Success = 1,
        Warning = 2
    }
    public void DisplayMessage(String sMessage, MsgType type)
    {
        try
        {
            if (sMessage.Trim() == "")
            {
                pnlAlert.Visible = false;
            }
            else
            {
                lblMsg.Text = sMessage;
                if (type == MsgType.Success)
                {
                    pnlAlert.CssClass = "alert alert-success alert-dismissible";
                    spIcon.InnerHtml = "<i class='fa fa-check-circle-o'></i>";
                }
                else if (type == MsgType.Warning)
                {
                    pnlAlert.CssClass = "alert alert-warning alert-dismissible";
                    spIcon.InnerHtml = "<i class='fa fa-exclamation-triangle'></i>";
                }
                else
                {
                    pnlAlert.CssClass = "alert alert-danger alert-dismissible";
                    spIcon.InnerHtml = "<i class='fa fa-exclamation-circle'></i>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "displayMsg", "alert('" + sMessage + "');", true);
                }
                pnlAlert.Visible = true;
                //ClientScript.RegisterStartupScript(this.GetType(), "displayMsg", "alert('" + sMessage + "');", true);
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            pnlAlert.Visible = true;
        }
    }
    protected void loginClick(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(username.Value) || string.IsNullOrWhiteSpace(username.Value))
            {
                DisplayMessage("Please enter your username", 0);
            }
            else if (password.Value == "")
            {
                DisplayMessage("Please enter your password", 0);
            }
            else
            {
                if (objAdm.getClientProfile(username.Value, password.Value))
                {
                    Session["audit_username"] = objAdm.Username ;
                    Session["username"] = objAdm.Username ;
                    Session["AdministratorID"] = objAdm.AdministratorID ;
                    Session["ManufacturerID"] = objAdm.ManufacturerID ;
                    Session["RetailerID"] = objAdm.RetailerID ;
                    Session["Administrator"] = objAdm.Administrator ;
                    Session["Manufacturer"] = objAdm.Manufacturer ;
                    Session["Retailer"] = objAdm.Retailer ;
                    Session["ProfilePic"] = objAdm.ProfilePic ;
                    Session["CreatedDate"] = objAdm.CreatedDate ;
                    Session["Courier"] = objAdm.Courier ;
                    Session["CourierID"] = objAdm.CourierID;

                    if (objAdm.Administrator  != "1")
                    {

                        if (objAdm.UserPassword   != "welcome")
                        {
                            Response.Redirect("Dashboard");
                        }
                        else
                        {
                            Response.Redirect("Change-Password");
                        }
                    }
                    else
                    {
                        Response.Redirect("Dashboard");
                    }
                }
                else
                {
                    DisplayMessage(objAdm.ErrorMessage, 0);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

}