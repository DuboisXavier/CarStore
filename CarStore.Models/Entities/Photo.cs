using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarStore.Models.Entities
{
    public class Photo
    {
        public int Id { get; set; }
        public string Nom { get; set; }
        public Byte[] Image { get; set; }
        public string MimeType { get; set; }
        public int PieceId { get; set; }

    }
}
