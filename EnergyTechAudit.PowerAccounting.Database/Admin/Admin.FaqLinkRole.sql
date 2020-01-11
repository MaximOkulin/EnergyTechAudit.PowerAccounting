
CREATE TABLE [Admin].[FaqLinkRole]
(
  [FaqId] INT NOT NULL, 
  [RoleId] INT NOT NULL
  CONSTRAINT PK_Admin_FaqLinkRole PRIMARY KEY (FaqId, RoleId),
	CONSTRAINT [FK_Admin_FaqLinkRole_FaqId_Admin_Faq_Id] FOREIGN KEY ([FaqId]) REFERENCES [Admin].[Faq]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Admin_FaqLinkRole_RoleId_Admin_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [Admin].[Role]([Id])
);
