using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Data
{
    public class ApiDbContext : IdentityDbContext<ApiUser>
    {
        public ApiDbContext()
        {

        }

        public ApiDbContext(DbContextOptions<ApiDbContext> options)
            : base(options)
        {
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                throw new Exception("Configuration is missing. See ApiDbContext to find this error message.");
            }
        }
    }
}
