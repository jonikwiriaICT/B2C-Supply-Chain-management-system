using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data;
using System.Data.SqlClient;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel : _Database
    {
     
        public string Message = string.Empty;
        public bool GetMessage(string Text)
        {
            try
            {
                DataSet ds = new DataSet();
                string sSQL = "SELECT DISTINCT top (1) replies, fms.score, SOUNDEX(queries) AS SoundexCode from tbl_chat CROSS APPLY(select dbo.FuzzyMatchString(@s1, queries) AS score) AS fms ORDER by fms.score desc";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@s1", Text);
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    return false;
                }
                Message = ds.Tables[0].Rows[0]["replies"].ToString();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public bool GetShipmentAddress(string Text)
        {
            try
            {
                DataSet ds = new DataSet();
                string sSQL = "SELECT DISTINCT top (1) product_address, fms.score, SOUNDEX(order_id) AS SoundexCode from tbl_shipment CROSS APPLY(select dbo.FuzzyMatchString(@s1, order_id) AS score) AS fms ORDER by fms.score desc";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@s1", Text);
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    return false;
                }
                Message ="Your product is still at " + "  " + ds.Tables[0].Rows[0]["product_address"].ToString();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
