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
    internal static class PhotoMapper
    {
        internal static Photo ToPhoto(this IDataRecord datarecord)
        {
            return new Photo()
            {
                Id = (int)datarecord["Id"],
                Nom = (string)datarecord["Nom"],
                Image = (Byte[])datarecord["Image"],
                MimeType = (string)datarecord["MimeType"],
                PieceId = (int)datarecord["PieceId"],
            };
        }

    }
}
