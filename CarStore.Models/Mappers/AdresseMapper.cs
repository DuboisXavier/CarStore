using CarStore.Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Mappers
{
    internal static class AdresseMapper
    {
        internal static Adresse ToAdresse(this IDataRecord datarecord)
        {
            return new Adresse()
            {
                Id = (int)datarecord["Id"],
                Numero = (string)datarecord["Numero"],
                Rue = (string)datarecord["Rue"],
                Ville = (string)datarecord["Ville"],
                CodePostal = (string)datarecord["CodePostal"],
                Pays = (string)datarecord["Pays"]
            };
        }
    }
}
