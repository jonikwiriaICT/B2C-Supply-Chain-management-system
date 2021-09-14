using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data;

public partial class ChatHistory : System.Web.UI.Page
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
                    getMessageLog();
                    
                }
            }
        }
        catch (Exception ex)
        {

        }
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
                    pnlAlert.CssClass = "alert alert-success";
                    spIcon.InnerHtml = "<i class='fa fa-check-circle-o'></i>";
                }
                else if (type == MsgType.Warning)
                {
                    pnlAlert.CssClass = "alert alert-warning";
                    spIcon.InnerHtml = "<i class='fa fa-exclamation-triangle'></i>";
                }
                else
                {
                    pnlAlert.CssClass = "alert alert-danger";
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

    protected void DeleteChat(object sender, EventArgs e)
    {
        try
        { 

            Session["audit_username"] = Session["ConsumerName"].ToString();
           
            string sTbl = "tbl_message_log";
                if (objAdm.DeleteMessageLog(Session["ConsumerID"].ToString (), sTbl) == true)
                {
                    DisplayMessage ("Record deleted successfully.", MsgType.Success);
                   getMessageLog();

                }
                else
                {
                DisplayMessage("Error deleting message.", MsgType.Error);
                getMessageLog();
                }
           
        }
        catch(Exception ex)
        {

        }
    }

    protected void NavigateFeedback(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Feedback");
        }
        catch(Exception ex)
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