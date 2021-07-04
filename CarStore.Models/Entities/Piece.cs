using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Entities
{
    public class Piece
    {
        public int Id { get; set; }
        public string Nom { get; set; }
        public string Reference { get; set; }
        public decimal Prix { get; set; }
        public int MarqueId { get; set; }

        public int CategorieId { get; set; }

    }
}
