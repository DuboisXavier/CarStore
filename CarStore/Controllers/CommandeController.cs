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
    public class CommandeController : ControllerBase
    {
        private readonly IBaseRepository<Commande> _repository;

        public CommandeController(IBaseRepository<Commande> repository)
        {
            _repository = repository;
        }
        // GET: api/<CommandeController>
        [HttpGet]
        public IEnumerable<Commande> Get()
        {
            return _repository.Get();
        }

        // GET api/<CommandeController>/5
        [HttpGet("{id}")]
        public Commande Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<CommandeController>
        [HttpPost]
        public void Post([FromBody] Commande value)
        {
            _repository.Insert(value);
        }

        // PUT api/<CommandeController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Commande value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<CommandeController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
