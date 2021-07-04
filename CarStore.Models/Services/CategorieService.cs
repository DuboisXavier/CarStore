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
    public class CategorieService : BaseService, IBaseRepository<Categorie_piece>
    {
        public CategorieService(IDbConnection connection) : base(connection)
        {

        }

        public bool Delete(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Categorie_piece where Id = @id";

            AddParameter(cmd, "Id", id);

            int nbLine = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbLine != 0;
        }

        public IEnumerable<Categorie_piece> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Categorie_piece";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToCategoriePiece();
            }
            _connection.Close();
        }

        public Categorie_piece Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Categorie_piece where Id = @id";
            AddParameter(cmd, "Id", id);

            IDataReader dataReader = cmd.ExecuteReader();

            Categorie_piece result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToCategoriePiece();
            }

            _connection.Close();
            return result;
        }

        public bool Insert(Categorie_piece entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddCategoriePiece";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Categorie", entity.Categorie);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;

        }

        public bool Update(int id, Categorie_piece entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdateCategoriePiece";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Id", id);
            AddParameter(cmd, "@Categorie", entity.Categorie);

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }
    }
}
