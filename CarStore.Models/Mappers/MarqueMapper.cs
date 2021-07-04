using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    public static class MarqueMapper
    {
        public static Marque ToMarque(this IDataRecord dataRecord)
        {
            return new Marque()
            {
                Id = (int)dataRecord["Id"],
                Nom_Marque = (string) dataRecord["Nom_Marque"]

            };
        }
    }
}
