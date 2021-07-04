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
    public class PhotoController : ControllerBase
    {
        private readonly IBaseRepository<Photo> _repository;


        public PhotoController(IBaseRepository<Photo> repository)
        {
            _repository = repository;
          
        }

 


        //-------------methode pour photo poco

        // GET: api/<PhotoController>
        [HttpGet]
        public IEnumerable<Photo> Get()
        {
            return _repository.Get();
        }

        // GET api/<PhotoController>/5
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            Photo p = _repository.Get(id);
            return File(p.Image, p.MimeType);
        }

        // POST api/<PhotoController>
        [HttpPost]
        public void Post([FromBody] Photo value)
        {
            _repository.Insert(value);
        }

        // PUT api/<PhotoController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Photo value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<PhotoController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
