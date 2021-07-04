using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class UtilisateurMapper
    {
        internal static Utilisateur ToUtilisateur(this IDataRecord dataRecord)
        {
            return new Utilisateur()
            {
                Id = (int)dataRecord["Id"],
                Nom = (string)dataRecord["Nom"],
                Prenom = (string)dataRecord["Prenom"],
                Email = (string)dataRecord["Email"],
                Telephone = (string)dataRecord["Telephone"],
                MotDePasse = (string)dataRecord["MotDePasse"],
                Role = (string)dataRecord["Role"],
                AdresseId = (int)dataRecord["AdresseId"]
            };
        }
    }
}
