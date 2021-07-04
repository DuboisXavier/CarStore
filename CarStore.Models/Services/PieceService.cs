using CarStore.models.Repositories;
using CarStore.models.Services;
using CarStore.Models.Entities;
using CarStore.Models.Mappers;
using CarStore.Models.Repositories;
using CarStore.Models.Views;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Services
{
    public class PieceService : BaseService, IPieceRepository
    {
        public PieceService(IDbConnection connection) : base(connection)
        {

        }
        public bool Delete(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "delete from Piece where Id = @id";

            AddParameter(cmd, "Id", id);

            int nbline = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbline != 0;
        }

        public IEnumerable<PieceMarqueView> GetPieceMarqueView()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = @"select P.*, M.Nom_Marque, C.Categorie, PH.Id as ImageId
            from Piece P 
            join Marque M on P.MarqueId = M.Id 
            join Categorie_piece C on P.CategorieId = C.Id 
            left join Photos PH on PH.PieceId = P.Id";
              

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToPieceMarqueView();
            }
            _connection.Close();
        }
        public IEnumerable<Piece> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Piece";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToPiece();
            }
            _connection.Close();
        }

        public Piece Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Piece where Id = @id";

            AddParameter(cmd, "Id", id);

            IDataReader dataReader = cmd.ExecuteReader();

            Piece result = null;
            if (dataReader.Read())
            {
                return dataReader.ToPiece();
            }
            _connection.Close();

            return result;
        }

        public bool Insert(Piece entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_AddPiece";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "@Nom", entity.Nom);
            AddParameter(cmd, "@Reference", entity.Reference);
            AddParameter(cmd, "@Prix", entity.Prix);
            AddParameter(cmd, "@MarqueId", entity.MarqueId);

            int nbline = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbline != 0;
        }

        public bool Update(int id, Piece entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "CSP_UpdatePiece";
            cmd.CommandType = CommandType.StoredProcedure;

            AddParameter(cmd, "Id", entity.Id);
            AddParameter(cmd, "@Nom", entity.Nom);
            AddParameter(cmd, "@Reference", entity.Reference);
            AddParameter(cmd, "@Prix", entity.Prix);
            AddParameter(cmd, "@MarqueId", entity.MarqueId);

            int nbline = cmd.ExecuteNonQuery();

            _connection.Close();

            return nbline != 0;
        }

        public IEnumerable<PieceMarqueView> GetPieceMarqueView(int id)
        {
            throw new NotImplementedException();
        }
    }
}
