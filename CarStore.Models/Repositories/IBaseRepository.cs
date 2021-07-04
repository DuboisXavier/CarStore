using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.models.Repositories
{
    public interface IBaseRepository<TEntity>
    {
        // get all
        IEnumerable<TEntity> Get();
        // get by id
        TEntity Get(int id);
        // insert
        bool Insert(TEntity entity);
        // update
        bool Update(int id, TEntity entity);
        // delete
        bool Delete(int id);
    }
}