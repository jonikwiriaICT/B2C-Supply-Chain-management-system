
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Configuration;

public partial class UserManagement : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    DataSet ds;
    DataTable Dt;
    static string sRecValue;
    static int itrig = 0;
    public int TotalPage { get; set; }
    public int CurrentPage { get; set; }

    public string Administrator()
    {
        try
        {
            string username = ((SupplyChainMaster)this.Master).Administrator;
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

            if (Administrator() == "1")
            {
                if (!IsPostBack)
                {
                    getUserType();
                    LoadGrid();
                   
                    formView.Visible = false;
                    TableView.Visible = true;


                }
                //LoadGrid(); 

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
    protected void GetUserTypeQuery(object sender, EventArgs e)
    {
        try
        {
            LoadGrid();
            formView.Visible = false;
            TableView.Visible = true;
        }
        catch(Exception ex)
        {

        }
    }
    private void getUserType()
    {
        try
        {
            DataSet ds = objAdm.getUserType();
            UserTypeID.DataSource = ds;
            UserTypeID.DataValueField = "Code";
            UserTypeID.DataTextField = "Desc";
            UserTypeID.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void AddNewRecordClicked(object sender, EventArgs e)
    {
        try
        {
            formView.Visible = true;
            TableView.Visible = false;
            LoadGrid();
            objAdm.clearPanel(PnlUserManagement);
            itrig = 0;
        }
        catch (Exception ex)
        {

        }
    }
    protected void ViewRecord(object sender, EventArgs e)
    {
        try
        {
            formView.Visible = false;
            TableView.Visible = true;
            LoadGrid();
            itrig = 0;
        }
        catch (Exception ex)
        {

        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {

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
    private void DisplaySuccess(String sMessage)
    {
        try
        {
            (this.Master as SupplyChainMaster).DisplayMessage(sMessage, SupplyChainMaster.MsgType.Success);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }
    private void DisplayError(String sMessage)
    {
        try
        {
            (this.Master as SupplyChainMaster).DisplayMessage(sMessage, SupplyChainMaster.MsgType.Error);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }

    private void DisplayWarning(String sMessage)
    {
        try
        {
            (this.Master as SupplyChainMaster).DisplayMessage(sMessage, SupplyChainMaster.MsgType.Warning);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }

    public string QueryUserTypeID()
    {
        if(UserTypeID .SelectedValue == "1")
        {
            return "GetManufacturer";
        }
        if (UserTypeID.SelectedValue == "2")
        {
            return "GetRetailer";
        }
        if (UserTypeID.SelectedValue == "3")
        {
            return "GetConsumer";
        }
        if (UserTypeID.SelectedValue == "4")
        {
            return "GetAdministrator";
        }
        if (UserTypeID.SelectedValue == "5")
        {
            return "GetCourier";
        }
        return "";
    }

    public void bindGrid(int currentPage)
    {

        TableResult.DataSource = objAdm.PopulateData(currentPage, QueryUserTypeID());
        TableResult.DataBind();

        generatePager(objAdm._TotalRowCount, objAdm.pageSize, currentPage);


    }
    public void bindGridUser(int currentPage)
    {

        UserGrid.DataSource = objAdm.PopulateData(currentPage, "GetUserManagement");
        UserGrid.DataBind();

        generatePager(objAdm._TotalRowCount, objAdm.pageSize, currentPage);


    }
    protected void dlPager_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "PageNo")
        {
            bindGrid(Convert.ToInt32(e.CommandArgument));
        }
        TableResult.UseAccessibleHeader = true;
        TableResult.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    protected void dlPager_ItemCommands(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "PageNo")
        {
            bindGridUser(Convert.ToInt32(e.CommandArgument));
        }
        TableResult.UseAccessibleHeader = true;
        TableResult.HeaderRow.TableSection = TableRowSection.TableHeader;
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

    public void generatePagerUser(int totalRowCount, int pageSize, int currentPage)
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

        UserGridDataList.DataSource = pageLinkContainer;
        UserGridDataList.DataBind();
    }
    private void LoadGrid()
    {
        try
        {
            bindGrid(1 );
            bindGridUser(1);
            TableResult.UseAccessibleHeader = true;
            TableResult.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        catch (Exception ex)
        {

        }
    }


    protected void tableChanged(object sender, EventArgs e)
    {
        try
        {

            itrig = 0;
            GetInputUser();
            formView.Visible = true;
            TableView.Visible = false;


        }
        catch (Exception ex)
        {

        }
    }
    protected void UserGridChanged(object sender, EventArgs e)
    {
        try
        {

            itrig = 1;
            GridViewRow dgi = UserGrid.SelectedRow;
            rec_id.Value = dgi.Cells[objAdm.getColumnIndexByName(UserGrid, "RecID")].Text;
            objAdm.getPanelByRecID(PnlUserManagement);
            formView.Visible = true;
            TableView.Visible = false;


        }
        catch (Exception ex)
        {

        }
    }
    protected void TableDelete(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow dgi = TableResult.Rows[e.RowIndex];
            rec_id.Value = dgi.Cells[objAdm.getColumnIndexByName(TableResult, "RecID")].Text;
            Label1.ForeColor = System.Drawing.Color.DarkRed;
            Label1.Text = "Are you sure that you want to delete Record with ID:" + " " + rec_id.Value + " " + " ?";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "LaunchServerSide", "$(function() { showDelete(); });", true);

        }
        catch (Exception ex)
        {
        }
    }
    protected void UserGridDelete(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow dgi = TableResult.Rows[e.RowIndex];
            rec_id.Value = dgi.Cells[objAdm.getColumnIndexByName(TableResult, "RecID")].Text;
            Label2.ForeColor = System.Drawing.Color.DarkRed;
            Label2.Text = "Are you sure that you want to delete Record with ID:" + " " + rec_id.Value + " " + " ?";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "LaunchServerSide", "$(function() { showDeletes(); });", true);

        }
        catch (Exception ex)
        {
        }
    }

    protected void lbDeleteYes_Click(object sender, EventArgs e)
    {
        try
        {
            if (Administrator() == "1")
            {
                string sTbl = "tbl_manufacturer";
                if (objAdm.DeleteRecord(rec_id.Value, sTbl) == true)
                {
                    DisplaySuccess("Record deleted successfully.");
                    LoadGrid();


                }
                else
                {

                }
            }
            else
            {
                Response.Redirect("error");
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void lbDeleteYess_Click(object sender, EventArgs e)
    {
        try
        {
            if (Administrator() == "1")
            {
                string sTbl = "tbl_usermanagement";
                if (objAdm.DeleteRecord(rec_id.Value, sTbl) == true)
                {
                    DisplaySuccess("Record deleted successfully.");
                    LoadGrid();


                }
                else
                {

                }
            }
            else
            {
                Response.Redirect("error");
            }
        }
        catch (Exception ex)
        {

        }
    }
    private void GetInputUser()
    {
        try
        {
            if(UserTypeID .SelectedValue == "1")
            {
                manufacturer.Value = "1";
                retailer.Value = "0";
                courier.Value = "0";
                consumer.Value = "0";
                administrator.Value = "0";
            }
            if (UserTypeID.SelectedValue == "2")
            {
                manufacturer.Value = "0";
                retailer.Value = "1";
                consumer.Value = "0";
                courier.Value = "0";
                administrator.Value = "0";
            }
            if (UserTypeID.SelectedValue == "3")
            {
                manufacturer.Value = "0";
                retailer.Value = "0";
                consumer.Value = "1";
                courier.Value = "0";
                administrator.Value = "0";
            }
            if (UserTypeID.SelectedValue == "4")
            {
                manufacturer.Value = "0";
                retailer.Value = "0";
                consumer.Value = "0";
                courier.Value = "0";
                administrator.Value = "1";
            }
            if (UserTypeID.SelectedValue == "5")
            {
                manufacturer.Value = "0";
                retailer.Value = "0";
                consumer.Value = "0";
                administrator.Value = "0";
                courier.Value = "1";
            }
        }
        catch(Exception ex)
        {

        }
    }

    protected void SaveChangesClicked(object sender, EventArgs e)
    {
        try
        {
            if (Administrator() == "1")
            {

                GetInputUser();
                if (itrig == 0)
                {
                  
                    if (objAdm.CRUDUserManagement(rec_id.Value , username.Text , objAdm .Encrypt ("welcome"), manufacturer .Value , retailer.Value , consumer.Value, administrator .Value , courier.Value, "dist/img/avatar3.png", UserTypeID.SelectedValue, "INSERT") == true)
                    {
                        LoadGrid();
                        DisplaySuccess(objAdm.ErrorMessage);

                        objAdm.clearPanel(PnlUserManagement);
                        itrig = 0;
                        LoadGrid();
                        //formView.Visible = false;
                        //TableView.Visible = true;
                    }
                    else
                    {
                        DisplayError(objAdm.ErrorMessage);
                        LoadGrid();
                    }
                }
                if (itrig == 1)
                {
                    
                    if (objAdm.CRUDUserManagement(rec_id.Value, username.Text, objAdm.Encrypt("welcome"), manufacturer.Value, retailer.Value, consumer.Value, administrator.Value, courier.Value, "dist/img/avatar3.png", UserTypeID.SelectedValue, "UPDATE") == true)
                    {
                        LoadGrid();
                        DisplaySuccess(objAdm.ErrorMessage);

                        objAdm.clearPanel(PnlUserManagement);
                        itrig = 0;
                        LoadGrid();
                        //formView.Visible = false;
                        //TableView.Visible = true;
                    }
                    else
                    {
                        DisplayError(objAdm.ErrorMessage);
                        LoadGrid();
                    }
                }

            }
            else
            {
                Response.Redirect("error");
            }
        }
        catch (Exception ex)
        {

        }
    }

}