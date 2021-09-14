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
        public bool CRUDShipemt(string RecID, string CourierID, string ProductAddress, string FlagOn)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDShipemt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@CourierID", CourierID );
            cmd.Parameters.AddWithValue("@ProductAddress", ProductAddress);
            cmd.Parameters.AddWithValue("@FlagOn", FlagOn);
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
