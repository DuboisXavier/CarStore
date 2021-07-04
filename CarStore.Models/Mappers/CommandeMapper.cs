using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class CommandeMapper
    {
        internal static Commande ToCommande(this IDataRecord dataRecord)
        {
            return new Commande()
            {
                Numero = (int)dataRecord["Numero"],
                Status = (string)dataRecord["Status"],
                Date = (string)dataRecord["Date"],
                UtilisateurId = (int)dataRecord["UtilisateurId"]
            };
        }
    }
}
