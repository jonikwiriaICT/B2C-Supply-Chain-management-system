using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data.SqlClient;
using System.Data;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel: _Database
    {
        public bool CRUDWarehouse(string RecID, string WarehouseName, string BranchID, string WarehouseDescription, string RetailerID, string StatementType) 
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDWarehouse", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@WarehouseName", WarehouseName);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            cmd.Parameters.AddWithValue("@WarehouseDescription", WarehouseDescription);
            cmd.Parameters.AddWithValue("@RetailerID", RetailerID );
            
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }

        public DataSet getBranchID()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select branch_id as [Code], branch_name as [Desc] from tbl_branch";
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
