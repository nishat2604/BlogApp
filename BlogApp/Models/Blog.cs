using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BlogApp.Models
{
    public partial class Blog
    {
        public Blog()
        {
            Post = new HashSet<Post>();
        }

        public int BlogId { get; set; }
        public string Url { get; set; }
        [DataType(DataType.Date),
  DisplayFormat(DataFormatString = @"{0:dd\/MM\/yyyy}", ApplyFormatInEditMode = false)]
        [Display(Name = "Creation Date")]

        public DateTime? DateCreated { get; set; }

        public virtual ICollection<Post> Post { get; set; }
    }
}
