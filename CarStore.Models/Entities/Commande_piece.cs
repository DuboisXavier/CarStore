using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Entities
{
    public class Commande_piece
    {
        public int Id { get; set; }
        public int Quantite { get; set; }
        public double Prix { get; set; }
        public int CommandeId { get; set; }
        public int PieceId { get; set; }
    }
}
