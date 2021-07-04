using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Entities
{
    public class Commande
    {
        public int Numero { get; set; }
        public string Status { get; set; }
        public string Date { get; set; }
        public int UtilisateurId { get; set; }
    }
}
