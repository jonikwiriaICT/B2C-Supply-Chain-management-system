
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;


public partial class _Default : System.Web.UI.Page
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
    protected void SignOut(object sender, EventArgs e)
    {
        try
        {
            if (sender.Equals(lnkSignOut))
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Index");
            }
            if (sender.Equals(lnkSignin))
            {
                Session["users"] = null;
                Response.Redirect("Consumer-Login");
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
            Response.Redirect("Consumer-Register");
        }
        catch(Exception ex)
        {

        }
    }
    protected void SignIn(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Consumer-Login");
        }
        catch(Exception ex)
        {

        }
    }
    protected void CartCheck(object sender, EventArgs e)
    {
        try
        {
            if (Session["users"] == null)
            {
                Response.Redirect("Consumer-Login");
            }
            else
            {
                Response.Redirect("Consumer-Cart");
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
           
                if (!IsPostBack)
                {
                if (Session["consumer"] == null)
                {
                    Session["consumer"] = "0";
                }

                bindGrid(1);
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

    protected void SearchProduct(object sender, EventArgs e)
    {
        try
        {
            bindGrid(1);
        }
        catch (Exception ex)
        {

        }
    }
    public void bindGrid(int currentPage)
    {

        LVProducts.DataSource = objAdm.PopulateData(currentPage, "GetRetailerProduct");
        LVProducts.DataBind();

        generatePager(objAdm._TotalRowCount, objAdm.pageSize, currentPage);
    }
    protected void dlPager_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "PageNo")
        {
            bindGrid(Convert.ToInt32(e.CommandArgument));
        }
    }
    public void generatePager(int totalRowCount, int pageSize, int currentPage)
    {
        int totalLinkInPage = 5;
        int totalPageCount = (int)Math.Ceiling((decimal)totalRowCount / pageSize);

        int startPageLink = Math.Max(currentPage - (int)Math.Floor((decimal)totalLinkInPage / 2), 1);
        int lastPageLink = Math.Min(startPageLink + totalLinkInPage - 1, totalPageCount);

        if ((startPageLink + totalLinkInPage - 1) > totalPageCount)
        {
            lastPageLink = Math.Min(currentPage + (int)Math.Floor((decimal)totalLinkInPage / 2), totalPageCount);
            startPageLink = Math.Max(lastPageLink - totalLinkInPage + 1, 1);
        }

        List<ListItem> pageLinkContainer = new List<ListItem>();

        if (startPageLink != 1)
            pageLinkContainer.Add(new ListItem("First", "1", currentPage != 1));
        for (int i = startPageLink; i <= lastPageLink; i++)
        {
            pageLinkContainer.Add(new ListItem(i.ToString(), i.ToString(), currentPage != i));
        }
        if (lastPageLink != totalPageCount)
            pageLinkContainer.Add(new ListItem("Last", totalPageCount.ToString(), currentPage != totalPageCount));

        dlPager.DataSource = pageLinkContainer;
        dlPager.DataBind();
    }

    protected void dtSpouse_itemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {

            switch (e.CommandName)
            {
                case "btnAddToCart":
                    var cookieCart = Request.Cookies["CookieCart"];
                    string itemID = e.CommandArgument.ToString();
                    if (cookieCart == null)
                    {
                        cookieCart = new HttpCookie("CookieCart");
                        cookieCart.Value = "";
                        cookieCart.Expires = DateTime.Now.AddDays(30);
                        cookieCart.Value = objAdm.Add(itemID, cookieCart.Value);
                        Response.Cookies.Add(cookieCart);
                    }
                    else
                    {
                        cookieCart.Value = objAdm.Add(itemID, cookieCart.Value);
                        Response.Cookies["CookieCart"].Value = cookieCart.Value;
                    }

                    Response.Redirect("Index");
                    break;
            }
        }

        catch (Exception ex)
        {

        }
    }
}