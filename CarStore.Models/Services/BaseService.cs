using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.models.Services
{
    public abstract class BaseService
    {
        // connection
        protected readonly IDbConnection _connection;

        public BaseService(IDbConnection connection)
        {
            _connection = connection;
        }
        // ajout de params
        protected void AddParameter(IDbCommand cmd, string parameterName, object value)
        {
            IDataParameter result = cmd.CreateParameter();
            result.ParameterName = parameterName;
            result.Value = value ?? DBNull.Value;
            cmd.Parameters.Add(result);
        }
    }
}
