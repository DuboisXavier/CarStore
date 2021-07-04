using CarStore.Models.Entities;
using CarStore.Models.Views;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class PieceMapper
    {
        internal static Piece ToPiece(this IDataRecord dataRecord)
        {
            return new Piece
            {
                Id = (int)dataRecord["Id"],
                Nom = (string)dataRecord["Nom"],
                Reference = (string)dataRecord["Reference"],
                Prix = (decimal)dataRecord["Prix"],
                MarqueId = (int)dataRecord["MarqueId"],
                CategorieId = (int)dataRecord["CategorieId"]
               
            };
        }


        internal static PieceMarqueView ToPieceMarqueView(this IDataRecord dataRecord)
        {
            return new PieceMarqueView
            {
                Id = (int)dataRecord["Id"],
                Nom = (string)dataRecord["Nom"],
                Reference = (string)dataRecord["Reference"],
                Prix = (decimal)dataRecord["Prix"],
                MarqueId = (int)dataRecord["MarqueId"],
                Nom_Marque = (string)dataRecord["Nom_Marque"],
                Categorie = (string)dataRecord["Categorie"],
                CategorieId = (int)dataRecord["CategorieId"],
                ImageId = dataRecord["ImageId"] as int?
            };
        }
    }
}
