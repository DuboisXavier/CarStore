using CarStore.models.Repositories;
using CarStore.models.Services;
using CarStore.Models.Entities;
using CarStore.Models.Mappers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Services
{
    public class AdresseService : BaseService, IBaseRepository<Adresse>
    {
        public AdresseService(IDbConnection connection) : base(connection)
        {

        }

        public bool Delete(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Adresse where Id = @id";

            AddParameter(cmd, "Id", id);

            int nbLine = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbLine != 0;
        }

        public IEnumerable<Adresse> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Adresse";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToAdresse();
            }
            _connection.Close();
        }

        public Adresse Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Adresse where Id = @id";

            AddParameter(cmd, "Id", id);
            IDataReader dataReader = cmd.ExecuteReader();
            Adresse result = null;

            if (dataReader.Read())
            {
                return dataReader.ToAdresse();
            }
            _connection.Close();
            return result;
        }

        public bool Insert(Adresse entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddAdresse";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Numero", entity.Numero);
            AddParameter(cmd, "@Rue", entity.Rue);
            AddParameter(cmd, "@Ville", entity.Ville);
            AddParameter(cmd, "@CodePostal", entity.CodePostal);
            AddParameter(cmd, "@Pays", entity.Pays);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
            
        }

        public bool Update(int id, Adresse entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdateAdresse";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "Id", entity.Id);
            AddParameter(cmd, "@Numero", entity.Numero);
            AddParameter(cmd, "@Rue", entity.Rue);
            AddParameter(cmd, "@Ville", entity.Ville);
            AddParameter(cmd, "@CodePostal", entity.CodePostal);
            AddParameter(cmd, "@Pays", entity.Pays);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }
    }
}
