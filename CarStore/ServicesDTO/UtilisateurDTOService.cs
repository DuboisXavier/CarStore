using CarStore.Models.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarStore.ServicesDTO
{
    public class UtilisateurDTOService
    {
        private readonly IUtilisateurRepository _service;
        public UtilisateurDTOService(IUtilisateurRepository service)
        {
            _service = service;
        }
    }
}
