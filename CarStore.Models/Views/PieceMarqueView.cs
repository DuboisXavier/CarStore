using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Views
{
    public class PieceMarqueView : Piece
    {
        public string Nom_Marque { get; set; }
        public string Categorie { get; set; }
        public int? ImageId { get; set; }
    }
}
