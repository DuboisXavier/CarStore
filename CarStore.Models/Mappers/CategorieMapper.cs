using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class CategorieMapper
    {
        internal static Categorie_piece ToCategoriePiece(this IDataRecord dataRecord)
        {
            return new Categorie_piece()
            {
                Id = (int)dataRecord["Id"],
                Categorie = (string)dataRecord["Categorie"]

            };
        }
    }
}
