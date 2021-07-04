using CarStore.DTO;
using CarStore.MappersDTO;
using CarStore.models.Repositories;
using CarStore.models.Services;
using CarStore.Models.Entities;
using CarStore.Models.Repositories;
using CarStore.Models.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace CarStore.ServicesDTO
{
    public class PieceDTOService
    {
        private readonly IPieceRepository _service;
        public PieceDTOService(IPieceRepository service)
        {
            _service = service;
        }

        public bool DeleteByCategorie(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PieceDTO> GetByCategorie()
        {
            return _service.GetPieceMarqueView().Select(p => p.ToPieceDTO());
        }

        public IEnumerable<PieceDTO> GetByCategorie(int id)
        {
            return _service.GetPieceMarqueView().Select(p => p.ToPieceDTO()).Where(p => p.CategorieId == id);
        }

        public bool InsertByCategorie(PieceDTO entity)
        {
            throw new NotImplementedException();
        }

        public bool UpdateByCategorie(int id, PieceDTO entity)
        {
            throw new NotImplementedException();
        }
    }
}
