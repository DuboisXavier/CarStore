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
    public class CommandeService : BaseService, IBaseRepository<Commande>
    {
        public CommandeService(IDbConnection connection) : base(connection)
        {

        }
        public bool Delete(int numero)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Commande where Numero = @numero";

            AddParameter(cmd, "Numero", numero);

            int nbLine = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbLine != 0;
        }

        public IEnumerable<Commande> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Commande";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToCommande();
            }
            _connection.Close();
        }

        public Commande Get(int numero)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Commande where Numero = @numero";
            AddParameter(cmd, "numero", numero);

            IDataReader dataReader = cmd.ExecuteReader();

            Commande result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToCommande();
            }

            _connection.Close();
            return result;
        }

        public bool Insert(Commande entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddCommand";
            cmd.CommandType = CommandType.StoredProcedure;
            
            AddParameter(cmd, "@status", entity.Status);
            AddParameter(cmd, "@date", entity.Date);
            AddParameter(cmd, "@UtilisateurId", entity.UtilisateurId);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }

        public bool Update(int id, Commande entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdateCommand";
            cmd.CommandType = CommandType.StoredProcedure;
            AddParameter(cmd, "@Numero", entity.Numero);
            AddParameter(cmd, "@status", entity.Status);
            AddParameter(cmd, "@date", entity.Date);
            AddParameter(cmd, "@UtilisateurId", entity.UtilisateurId);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }
    }
}
