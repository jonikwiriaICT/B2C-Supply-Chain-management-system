using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SupplyChainLibrary
{
    public interface IDataAccess
    {
        object GetScalar(string sql);
        // DataSet GetDataSet(string sql);
        DataTable GetDataTable(string sql);
        int InsOrUpdOrDel(string sql);
    }
}
