USE [Pronto]
GO
/****** Object:  Table [dbo].[userProjects]    Script Date: 08/08/2007 01:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userProjects](
	[userid] [int] NOT NULL,
	[projectid] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tasks]    Script Date: 08/08/2007 01:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tasks](
	[taskid] [int] IDENTITY(1,1) NOT NULL,
	[taskText] [varchar](8000) NOT NULL,
	[startDate] [datetime] NOT NULL,
	[dueDate] [datetime] NOT NULL,
	[hours] [float] NULL CONSTRAINT [DF_tasks_hours]  DEFAULT ((0.00)),
	[priority] [int] NULL,
	[projectid] [int] NOT NULL,
	[isInvoiced] [bit] NULL CONSTRAINT [DF_tasks_isInvoiced]  DEFAULT ((0)),
	[invoiceDate] [datetime] NULL,
	[isComplete] [bit] NULL CONSTRAINT [DF_tasks_isComplete]  DEFAULT ((0)),
	[optionalDesc] [varchar](8000) NULL,
 CONSTRAINT [PK_tasks] PRIMARY KEY CLUSTERED 
(
	[taskid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[users]    Script Date: 08/08/2007 01:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[userid] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](250) NOT NULL,
	[lastName] [varchar](250) NOT NULL,
	[userName] [varchar](20) NOT NULL,
	[password] [varchar](35) NOT NULL,
	[email] [varchar](350) NULL,
	[lastVisit] [datetime] NULL,
	[role] [varchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[userClients]    Script Date: 08/08/2007 01:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userClients](
	[userid] [int] NOT NULL,
	[clientid] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[listTypes]    Script Date: 08/08/2007 01:18:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[listTypes](
	[typeid] [int] IDENTITY(1,1) NOT NULL,
	[sDesc] [varchar](250) NOT NULL,
	[sType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_listTypes] PRIMARY KEY CLUSTERED 
(
	[typeid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[userTasks]    Script Date: 08/08/2007 01:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userTasks](
	[userid] [int] NOT NULL,
	[taskid] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[projects]    Script Date: 08/08/2007 01:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[projects](
	[projectid] [int] IDENTITY(1,1) NOT NULL,
	[projectName] [varchar](250) NOT NULL,
	[clientid] [int] NOT NULL,
	[billRate] [float] NULL,
 CONSTRAINT [PK_projects] PRIMARY KEY CLUSTERED 
(
	[projectid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[clients]    Script Date: 08/08/2007 01:17:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clients](
	[clientid] [int] IDENTITY(1,1) NOT NULL,
	[clientName] [varchar](350) NOT NULL,
	[address1] [varchar](250) NOT NULL,
	[address2] [varchar](250) NULL,
	[city] [varchar](150) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[zip] [varchar](50) NOT NULL,
 CONSTRAINT [PK_clients] PRIMARY KEY CLUSTERED 
(
	[clientid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contacts]    Script Date: 08/08/2007 01:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contacts](
	[contactid] [int] IDENTITY(1,1) NOT NULL,
	[contactname] [varchar](450) NOT NULL,
	[workphone1] [varchar](20) NULL,
	[workphone2] [varchar](20) NULL,
	[cellphone] [varchar](20) NULL,
	[zip] [varchar](20) NULL,
	[fax] [varchar](20) NULL,
	[email1] [varchar](350) NOT NULL,
	[email2] [varchar](350) NULL,
	[clientid] [int] NOT NULL,
 CONSTRAINT [PK_contacts] PRIMARY KEY CLUSTERED 
(
	[contactid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
