using CarStore.Models.Entities;
using CarStore.models.Repositories;
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
    public class MarqueController : ControllerBase
    {
        private readonly IBaseRepository<Marque> _repository;

        public MarqueController(IBaseRepository<Marque> repository)
        {
            _repository = repository;
        }
        // GET: api/<MarqueController>
        [HttpGet]
        public IEnumerable<Marque> Get()
        {
            return _repository.Get();
        }

        // GET api/<MarqueController>/5
        [HttpGet("{id}")]
        public Marque Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<MarqueController>
        [HttpPost]
        public IActionResult Post([FromBody] Marque value)
        {
            //if (!User.IsInRole("ADMIN"))
            //{
            //    return Unauthorized();
            //}
            return Ok(_repository.Insert(value));
        }

        // PUT api/<MarqueController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Marque value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<MarqueController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
