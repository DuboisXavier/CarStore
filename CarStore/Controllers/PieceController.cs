using CarStore.DTO;
using CarStore.models.Repositories;
using CarStore.Models.Entities;
using CarStore.ServicesDTO;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CarStore.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PieceController : ControllerBase
    {
        private readonly IBaseRepository<Piece> _repository;
        private readonly PieceDTOService _repos;
        public PieceController(IBaseRepository<Piece> repository, PieceDTOService repos)
        {
            _repository = repository;
            _repos = repos;
        }


        //--------methodes triant les pieces par rapport a leur categorie

        [Route("bycat")]
        [HttpGet]
        public IEnumerable<PieceDTO> GetByCategorie()
        {
            return _repos.GetByCategorie();
        }

        [Route("bycat/{id}")]
        [HttpGet]
        public IEnumerable<PieceDTO> GetByCategorie(int id)
        {
            return _repos.GetByCategorie(id);

        }

        [Route("postbycat")]
        [HttpPost]
        public void PostByCategorie([FromBody] string value)
        {
        }

        //PUT api/<PieceNomController>/5
        [Route("putbycat/{id}/{value}")]
        [HttpPut]
        public void PutByCategorie(int id, [FromBody] string value)
        {
        }

        // DELETE api/<PieceNomController>/5
        [Route("deletebycat/{id}")]
        [HttpDelete]
        public void DeleteByCategorie(int id)
        {
        }

        //--------------methodes pour les piece poco

        [HttpGet]
        public IEnumerable<Piece> Get()
        {
            return _repository.Get();
        }

        // GET api/<PieceController>/5

        [HttpGet("{id}")]        
        public Piece Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<PieceController>
        [HttpPost]
        public void Post([FromBody] Piece value )
        {
            _repository.Insert(value);
        }

        // PUT api/<PieceController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Piece value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<PieceController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
