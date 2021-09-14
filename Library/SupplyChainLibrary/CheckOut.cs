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
    public partial class SysAdminModel: _Database
    {

        public DataSet GetPurchaseType()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select rec_id as [Code], purchase_type_name as [Desc] from tbl_purchasetype";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
        public DataSet GetWarehouse(string RetailerID)
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select rec_id as [Code], warehouse_name as [Desc] from tbl_warehouse where manufacturer_id='"+ RetailerID + "'";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
    }
}
