using CarStore.models.Repositories;
using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Repositories
{
    public interface IUtilisateurRepository : IBaseRepository<Utilisateur>
    {
        Utilisateur CheckUser(Utilisateur utilisateur);
    }
}
