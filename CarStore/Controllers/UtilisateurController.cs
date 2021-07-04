using C.Tools.Security.Jwt.Services;
using CarStore.DTO;
using CarStore.models.Repositories;
using CarStore.Models.Entities;
using CarStore.Models.Services;
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
    public class UtilisateurController : ControllerBase
    {
        private readonly IBaseRepository<Utilisateur> _repository;
        private readonly JwtService _tokenService;
        private readonly UtilisateurService _repos;

        public UtilisateurController(IBaseRepository<Utilisateur> repository,JwtService service)
        {
            _repository = repository;
            _tokenService = service;
           
         
        }
        //GET: api/<UtilisateurController>
        [Route("api/Auth/Login")]
        [HttpPost]
        public string Login(Utilisateur utilisateur)
        {
            //return _repos.CheckUser(utilisateur);
            //  GetConnectedUser
            return _tokenService.Encode(new UtilisateurDTO
            {
                Id = 1,
                Email = "test",
                Role = "ADMIN"
            });
        }
        [HttpGet]
        public IEnumerable<Utilisateur> Get()
        {
            return _repository.Get();
        }

        // GET api/<UtilisateurController>/5
        [HttpGet("{id}")]
        public Utilisateur Get(int id)
        {
            return _repository.Get(id);
        }

        // POST api/<UtilisateurController>
        [HttpPost]
        public void Post([FromBody] Utilisateur value)
        {
            _repository.Insert(value);
        }

        // PUT api/<UtilisateurController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Utilisateur value)
        {
            _repository.Update(id, value);
        }

        // DELETE api/<UtilisateurController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}
