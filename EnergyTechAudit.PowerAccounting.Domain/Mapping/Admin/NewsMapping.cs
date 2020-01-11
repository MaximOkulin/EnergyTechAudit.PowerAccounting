﻿using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{

    public class NewsMapping : EntityTypeConfiguration<News>
    {
        public NewsMapping()
        {
            HasKey(t => t.Id);
            ToTable("News", "Admin");
        }
    }
}
