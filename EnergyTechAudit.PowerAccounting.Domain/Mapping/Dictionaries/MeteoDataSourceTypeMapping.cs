﻿using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class MeteoDataSourceTypeMapping : EntityTypeConfiguration<MeteoDataSourceType>
    {
        public MeteoDataSourceTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("MeteoDataSourceType", "Dictionaries");
        }
    }
}
