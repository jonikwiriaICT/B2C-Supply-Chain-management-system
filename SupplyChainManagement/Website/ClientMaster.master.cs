using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data;

public partial class ClientMaster : System.Web.UI.MasterPage
{
    SysAdminModel objAdm = new SysAdminModel();
    string s;
    string t;
    string[] a = new string[6];
    decimal tot = 0;
    int totalCount = 0;
    public string sCountMoney;
    public string sCountCart;
    Dictionary<string, string> dictionaryCart;
    DataTable dtblProducts;
    DataTable dtblCart;
    public int totalQuantity = 0;
    public double totalAmount = 0;
    public string ConsumerID
    {
        get
        {
            try
            {
                string sValue = string.Empty;

                if (string.IsNullOrEmpty(sValue) == true)
                {
                    sValue = Session["consumer"].ToString();
                }
                return sValue;
            }
            catch (Exception ex)
            {
                try
                {
                    return Session["consumer"].ToString();
                }
                catch (Exception ex2) { }
                return string.Empty;
            }
        }
    }
    public string ConsumerName
    {
        get
        {
            try
            {
                string sValue = string.Empty;

                if (string.IsNullOrEmpty(sValue) == true)
                {
                    sValue = Session["ConsumerName"].ToString();
                }
                return sValue;
            }
            catch (Exception ex)
            {
                try
                {
                    return Session["ConsumerName"].ToString();
                }
                catch (Exception ex2) { }
                return string.Empty;
            }
        }
    }

    public string ConsumerCreatedDate
    {
        get
        {
            try
            {
                string sValue = string.Empty;

                if (string.IsNullOrEmpty(sValue) == true)
                {
                    sValue = Session["ConsumerCreatedDate"].ToString();
                }
                return sValue;
            }
            catch (Exception ex)
            {
                try
                {
                    return Session["ConsumerCreatedDate"].ToString();
                }
                catch (Exception ex2) { }
                return string.Empty;
            }
        }
    }
    public string ConsumerEmail
    {
        get
        {
            try
            {
                string sValue = string.Empty;

                if (string.IsNullOrEmpty(sValue) == true)
                {
                    sValue = Session["ConsumerEmail"].ToString();
                }
                return sValue;
            }
            catch (Exception ex)
            {
                try
                {
                    return Session["ConsumerEmail"].ToString();
                }
                catch (Exception ex2) { }
                return string.Empty;
            }
        }
    }
    protected void SignOut(object sender, EventArgs e)
    {
        try
        {
            if(sender.Equals (lnkSignOut))
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Index");
            }
            if(sender.Equals (lnkSignin))
            {
                Response.Redirect("Consumer-Login");
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {
                Session["audit_username"] = Session["ConsumerName"].ToString();
                if (Session["consumer"]== null)
                {
                    Response.Redirect("Consumer-Login");
                }
               
                    GetIdentity();
                    var cookieCart = Request.Cookies["CookieCart"];

                    if (cookieCart != null)
                    {
                        sCountCart = objAdm.GetNumberOfItems(cookieCart.Value).ToString();

                    }
                    else
                    {
                        sCountCart = "0";
                    }


             
            }



        }
        catch (Exception ex)
        {

        }
    }

    private void GetIdentity()
    {
        try
        {
         
            lblUsername.Text = ConsumerName ;
            lblUsername1.Text = ConsumerEmail ;
            lblCreatedDate.Text = ConsumerCreatedDate ;
        
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
protected void CartCheck(object sender, EventArgs e)
    {
        try
        {
            if(ConsumerID ==null)
            {
                Response.Redirect("Consumer-Login");
            }
            else
            {
                Response.Redirect("Consumer-Cart");
            }
        }
        catch(Exception ex)
        {

        }
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
}
