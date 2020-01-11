﻿using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class TimeSignatureMapping : EntityTypeConfiguration<TimeSignature>
    {
        public TimeSignatureMapping()
        {
            HasKey(t => t.Id);

            ToTable("TimeSignature", "Business");
        }
    }
}