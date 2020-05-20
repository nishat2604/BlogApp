using System;
using System.Collections.Generic;

namespace BlogApp.DB
{
    public partial class Blog
    {
        public Blog()
        {
            Post = new HashSet<Post>();
        }

        public int BlogId { get; set; }
        public string Url { get; set; }
        public DateTime? DateCreated { get; set; }

        public virtual ICollection<Post> Post { get; set; }
    }
}
