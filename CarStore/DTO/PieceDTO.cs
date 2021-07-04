using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarStore.DTO
{
    public class PieceDTO
    {
        public string Nom { get; set; }
        public string Nom_Marque { get; set; }
        public string Categorie_piece { get; set; }
        public int CategorieId { get; set; }
        public string ImageUrl { get; set; }

    }
}
