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
    public class AdresseController : ControllerBase
    {
        private readonly IBaseRepository<Adresse> _repository;

        public AdresseController(IBaseRepository<Adresse> repository)
        {
            _repository = repository;
        }

        // GET: api/<AdresseController>
        [HttpGet]
        public IEnumerable<Adresse> Get()
        {
            return _repository.Get();
        }

        // GET api/<AdresseController>/5
        [HttpGet("{id}")]
        public Adresse Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<AdresseController>
        [HttpPost]
        public void Post([FromBody] Adresse value)
        {
            _repository.Insert(value);
        }

        // PUT api/<AdresseController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Adresse value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<AdresseController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
