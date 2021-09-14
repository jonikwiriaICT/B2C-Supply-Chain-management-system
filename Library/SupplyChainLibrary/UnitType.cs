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

        public bool CRUDUnitType(string RecID, string UnitType, string UnitDescription, string StatementType)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDUnitType", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@UnitType", UnitType);
            cmd.Parameters.AddWithValue("@UnitDescription", UnitDescription );
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }
    }
}
