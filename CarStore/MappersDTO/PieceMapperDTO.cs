using CarStore.DTO;
using CarStore.Models.Entities;
using CarStore.Models.Views;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace CarStore.MappersDTO
{
    internal static class PieceMapper
    {
        internal static PieceDTO ToPieceDTO(this PieceMarqueView entity)
        {
            return new PieceDTO
            {
                
                Nom = entity.Nom,
                Nom_Marque = entity.Nom_Marque,
                Categorie_piece = entity.Categorie,
                CategorieId = entity.CategorieId,
                ImageUrl = entity.ImageId != null ? "/photo/" + entity.ImageId : null

            };
        }
    }
}
