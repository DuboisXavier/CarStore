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
    public class Commande_pieceService : BaseService, IBaseRepository<Commande_pieceService>
    {
        public Commande_pieceService(IDbConnection connection): base(connection)
        {

        }
        public bool Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Commande_pieceService> Get()
        {
            throw new NotImplementedException();
        }

        public Commande_pieceService Get(int id)
        {
            throw new NotImplementedException();
        }

        public bool Insert(Commande_pieceService entity)
        {
            throw new NotImplementedException();
        }

        public bool Update(int id, Commande_pieceService entity)
        {
            throw new NotImplementedException();
        }
    }
}
