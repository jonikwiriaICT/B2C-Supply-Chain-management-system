using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using SupplyChainLibrary;

/// <summary>
/// Summary description for trcnWebServices
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Report : System.Web.Services.WebService
{
    SysAdminModel objAdm = new SysAdminModel();
    public static string DB = "LICENSED";

    public Report()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<object> GetManufacturerSales()
    {
        List<object> iData = new List<object>();
        List<string> labels = new List<string>();
        List<string> labels1 = new List<string>();
        string query1 = "select CreatedDate as [Status], sum(Quantity * SoldPrice)  as [Total] from qry_report_manufacturer where Rem >0 group by CreatedDate";
        DataTable dtLabels = commonFuntionGetData(query1);
        foreach (DataRow drow in dtLabels.Rows)
        {

            labels.Add(drow["Status"].ToString());
            labels1.Add(drow["Total"].ToString());
        }
        iData.Add(labels);
        iData.Add(labels1);
        return iData;
    }
    [WebMethod]
    public List<object> GetManufacturerSalesCancelled()
    {
        List<object> iData = new List<object>();
        List<string> labels = new List<string>();
        List<string> labels1 = new List<string>();
        string query1 = "select CreatedDate as [Status], sum(Quantity * SoldPrice)  as [Total] from qry_report_manufacturer where Rem =0 group by CreatedDate";
        DataTable dtLabels = commonFuntionGetData(query1);
        foreach (DataRow drow in dtLabels.Rows)
        {

            labels.Add(drow["Status"].ToString());
            labels1.Add(drow["Total"].ToString());
        }
        iData.Add(labels);
        iData.Add(labels1);
        return iData;
    }


    [WebMethod]
    public List<object> GetRetailerSales()
    {
        List<object> iData = new List<object>();
        List<string> labels = new List<string>();
        List<string> labels1 = new List<string>();
        string query1 = "select CreatedDate as [Status], sum(Quantity * Price) as [Total] from qry1 where Rem > 0 group by CreatedDate order by CreatedDate asc";
        DataTable dtLabels = commonFuntionGetData(query1);
        foreach (DataRow drow in dtLabels.Rows)
        {
            labels.Add(drow["Status"].ToString());
            labels1.Add(drow["Total"].ToString());
        }
        iData.Add(labels);
        iData.Add(labels1);
        return iData;
    }

    [WebMethod]
    public List<object> GetRetailerSalesCancelled()
    {
        List<object> iData = new List<object>();
        List<string> labels = new List<string>();
        List<string> labels1 = new List<string>();
        string query1 = "select CreatedDate as [Status], sum(Quantity * Price) as [Total] from qry1 where Rem = 0 group by CreatedDate order by CreatedDate asc";
        DataTable dtLabels = commonFuntionGetData(query1);
        foreach (DataRow drow in dtLabels.Rows)
        {
            labels.Add(drow["Status"].ToString());
            labels1.Add(drow["Total"].ToString());
        }
        iData.Add(labels);
        iData.Add(labels1);
        return iData;
    }
    public DataTable commonFuntionGetData(string strQuery)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ToString());
        SqlDataAdapter dap = new SqlDataAdapter(strQuery, cn);
        DataSet ds = new DataSet();
        dap.Fill(ds);
        cn.Close();
        cn.Dispose();
        return ds.Tables[0];
    }

}
