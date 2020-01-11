CREATE TABLE [Business].[ChannelLinkAgreementParameter]
(
	[ChannelId] INT NOT NULL,
	[AgreementParameterId] INT NOT NULL,

	CONSTRAINT [PK_Business_ChannelLinkAgreementParameter] PRIMARY KEY ([ChannelId],[AgreementParameterId]),
	CONSTRAINT [FK_Business_ChannelLinkAgreementParameter_ChannelId_Business_Channel_Id] FOREIGN KEY ([ChannelId]) REFERENCES [Business].[Channel]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_ChannelLinkAgreementParameter_AgreementParameterId_Business_AgreementParameter_Id] FOREIGN KEY ([AgreementParameterId]) REFERENCES [Business].[AgreementParameter]([Id]) ON DELETE CASCADE
);

GO

CREATE NONCLUSTERED INDEX [IX_Business_ChannelLinkAgreementParameter_ChannelId]
  ON [Business].[ChannelLinkAgreementParameter] ([ChannelId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_ChannelLinkAgreementParameter_AgreementParameterId]
  ON [Business].[ChannelLinkAgreementParameter] ([AgreementParameterId]);