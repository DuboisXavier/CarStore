using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class Commande_pieceMapper
    {
        internal static Commande_piece ToCommande_Piece(IDataRecord datarecord)
        {
            return new Commande_piece()
            {
                Id = (int)datarecord["Id"],
                Quantite = (int)datarecord["Quantite"],
                Prix = (double)datarecord["Prix"],
                CommandeId = (int)datarecord["CommandeId"],
                PieceId = (int)datarecord["PieceId"]
            };
        }
    }
}
