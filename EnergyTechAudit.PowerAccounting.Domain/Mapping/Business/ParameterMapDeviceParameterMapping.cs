using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class ParameterMapDeviceParameterMapping : EntityTypeConfiguration<ParameterMapDeviceParameter>
    {
        public ParameterMapDeviceParameterMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.Parameter)
                .WithMany(p => p.ParameterMapDeviceParameters)
                .HasForeignKey(d => d.ParameterId);

            HasRequired(p => p.MeasurementUnit)
                .WithMany(p => p.ParameterMapDeviceParameters)
                .HasForeignKey(d => d.MeasurementUnitId);

            HasRequired(p => p.Dimension)
                .WithMany(p => p.ParameterMapDeviceParameteres)
                .HasForeignKey(d => d.DimensionId);

            HasRequired(p => p.DeviceParameter)
                .WithMany(p => p.ParameterMapDeviceParameters)
                .HasForeignKey(d => d.DeviceParameterId);

            HasRequired(p => p.ChannelTemplate)
                .WithMany(p => p.ParameterMapDeviceParameters)
                .HasForeignKey(d => d.ChannelTemplateId);

            HasRequired(p => p.SubsystemType)
                .WithMany(p => p.ParameterMapDeviceParameters)
                .HasForeignKey(d => d.SubsystemTypeId);

            ToTable("ParameterMapDeviceParameter", "Business");
        }
    }
}
