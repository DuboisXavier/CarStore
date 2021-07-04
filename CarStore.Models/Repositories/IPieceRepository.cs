using CarStore.models.Repositories;
using CarStore.Models.Entities;
using CarStore.Models.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Repositories
{
    public interface IPieceRepository : IBaseRepository<Piece>
    {
        IEnumerable<PieceMarqueView> GetPieceMarqueView();
        IEnumerable<PieceMarqueView> GetPieceMarqueView(int id);
    }
}
