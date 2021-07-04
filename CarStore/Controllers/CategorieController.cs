using CarStore.models.Repositories;
using CarStore.Models.Entities;
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
    public class CategorieController : ControllerBase
    {
        private readonly IBaseRepository<Categorie_piece> _repository;

        public CategorieController(IBaseRepository<Categorie_piece> repository)
        {
            _repository = repository;
        }
        // GET: api/<CategoriePieceController>
        [HttpGet]
        public IEnumerable<Categorie_piece> Get()
        {
            return _repository.Get();
        }

        // GET api/<CategoriePieceController>/5
        [HttpGet("{id}")]
        public Categorie_piece Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<CategoriePieceController>
        [HttpPost]
        public void Post([FromBody] Categorie_piece value)
        {
            _repository.Insert(value);
        }

        // PUT api/<CategoriePieceController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Categorie_piece value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<CategoriePieceController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
