using CarStore.Models.Entities;
using CarStore.Models.Mappers;
using CarStore.models.Repositories;
using CarStore.models.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Services
{
    public class MarqueService : BaseService, IBaseRepository<Marque>
    {
        public MarqueService(IDbConnection connection) : base(connection)
        {

        }
        public bool Delete(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Marque where Id = @id";

            AddParameter(cmd, "Id", id);

            int nbLine = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbLine != 0;
        }

        public IEnumerable<Marque> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Marque";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToMarque();
            }
            _connection.Close();
        }

        public Marque Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Marque where Id = @id";
            AddParameter(cmd, "Id", id);

            IDataReader dataReader = cmd.ExecuteReader();

            Marque result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToMarque();
            }

            _connection.Close();
            return result;
        }

        public bool Insert(Marque entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddMarque";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Nom_Marque", entity.Nom_Marque);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }

        public bool Update(int id, Marque entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdateMarque";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Id", id);
            AddParameter(cmd, "@Nom_Marque", entity.Nom_Marque);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }
    }
}
