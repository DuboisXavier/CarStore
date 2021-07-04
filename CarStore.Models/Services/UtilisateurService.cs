using CarStore.models.Repositories;
using CarStore.models.Services;
using CarStore.Models.Entities;
using CarStore.Models.Mappers;
using CarStore.Models.Repositories;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Services
{
    public class UtilisateurService : BaseService, IUtilisateurRepository
    {
        public UtilisateurService(IDbConnection connection) : base(connection)
        {
        }

        public bool Delete(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Utilisateur where Id = @id";
            AddParameter(cmd, "Id", id);
            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }

        public IEnumerable<Utilisateur> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Utilisateur";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToUtilisateur();
            }
            _connection.Close();

        }

        public Utilisateur Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Utilisateur where Id = @id";
            AddParameter(cmd, "Id", id);

            IDataReader dataReader = cmd.ExecuteReader();

            Utilisateur result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToUtilisateur();
            }

            _connection.Close();
            return result;
        }

        public bool Insert(Utilisateur entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddUtilisateur";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "nom", entity.Nom);
            AddParameter(cmd, "prenom", entity.Prenom);
            AddParameter(cmd, "email", entity.Email);
            AddParameter(cmd, "telephone", entity.Telephone);
            AddParameter(cmd, "motDePasse", entity.MotDePasse);
            AddParameter(cmd, "role", entity.Role);
            AddParameter(cmd, "adresseId", entity.AdresseId);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }

        public bool Update(int id, Utilisateur entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdateUtilisateur";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "id", entity.Id);
            AddParameter(cmd, "nom", entity.Nom);
            AddParameter(cmd, "prenom", entity.Prenom);
            AddParameter(cmd, "email", entity.Email);
            AddParameter(cmd, "telephone", entity.Telephone);
            AddParameter(cmd, "motDePasse", entity.MotDePasse);
            AddParameter(cmd, "role", entity.Role);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }


        public Utilisateur CheckUser(Utilisateur utilisateur)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_CheckUser";
            cmd.CommandType = CommandType.StoredProcedure;

            IDataReader dataReader = cmd.ExecuteReader();

            Utilisateur result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToUtilisateur();
            }

            _connection.Close();
            return result;
        }


    }
}
