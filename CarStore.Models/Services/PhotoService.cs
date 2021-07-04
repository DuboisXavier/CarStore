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
    public class PhotoService : BaseService, IBaseRepository<Photo>
    {
        public PhotoService(IDbConnection connection) : base(connection)
        {
        }

        public bool Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Photo> Get()
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select * from Photos";

            IDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                yield return dataReader.ToPhoto();
            }
            _connection.Close();
        }

        public Photo Get(int id)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "select *from Photos where Id = @id";
            AddParameter(cmd, "Id", id);

            IDataReader dataReader = cmd.ExecuteReader();

            Photo result = null;

            if (dataReader.Read())
            {
                result = dataReader.ToPhoto();
            }

            _connection.Close();
            return result;
        }

        public bool Insert(Photo entity)
        {
            _connection.Open();
            IDbCommand cmd = _connection.CreateCommand();
            cmd.CommandText = "insert into Photos(Nom, MimeType, Image, PieceId) values(@nom, @mimeType, @image, @pieceId)";
           

            AddParameter(cmd, "nom", entity.Nom);
            AddParameter(cmd, "mimeType", entity.MimeType);
            AddParameter(cmd, "image", entity.Image);
            AddParameter(cmd, "pieceId", entity.PieceId);
       

            int nbLine = cmd.ExecuteNonQuery();
            _connection.Close();
            return nbLine != 0;
        }

        public bool Update(int id, Photo entity)
        {
            throw new NotImplementedException();
        }
    }
}
