USE [SmartHomeAutomation]
GO
/****** Object:  Table [dbo].[Alert]    Script Date: 2024-06-19 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alert](
	[alert_id] [int] IDENTITY(1,1) NOT NULL,
	[home_id] [int] NOT NULL,
	[device_id] [varchar](50) NOT NULL,
	[alert_type] [varchar](50) NULL,
	[alert_message] [varchar](50) NULL,
	[alert_time] [datetime] NULL,
 CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED 
(
	[alert_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2024-06-19 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] NOT NULL,
	[home_id] [int] NOT NULL,
	[first_name] [varchar](20) NOT NULL,
	[last_name] [varchar](20) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[access_level] [varchar](20) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 2024-06-19 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[device_id] [varchar](50) NOT NULL,
	[home_id] [int] NOT NULL,
	[device_name] [varchar](50) NOT NULL,
	[device_type] [varchar](10) NOT NULL,
	[manufacturer] [varchar](50) NULL,
	[installation_date] [date] NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Home]    Script Date: 2024-06-19 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Home](
	[home_id] [int] NOT NULL,
	[address] [varchar](50) NOT NULL,
	[city] [varchar](50) NULL,
	[province] [varchar](50) NULL,
	[owner_name] [varchar](50) NULL,
 CONSTRAINT [PK_Home] PRIMARY KEY CLUSTERED 
(
	[home_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 2024-06-19 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[device_id] [varchar](50) NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[action] [varchar](50) NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alert]  WITH CHECK ADD  CONSTRAINT [FK_Alert] FOREIGN KEY([home_id])
REFERENCES [dbo].[Home] ([home_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Alert] CHECK CONSTRAINT [FK_Alert]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_User] FOREIGN KEY([home_id])
REFERENCES [dbo].[Home] ([home_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_User]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device] FOREIGN KEY([home_id])
REFERENCES [dbo].[Home] ([home_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([device_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CHK_DeviceType] CHECK  (([device_type]='other' OR [device_type]='lock' OR [device_type]='sensor' OR [device_type]='camera' OR [device_type]='light'))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CHK_DeviceType]
GO





-- PostgreSQL Version

-- Create Home table
CREATE TABLE "Home" (
    "home_id" SERIAL PRIMARY KEY,
    "address" VARCHAR(50) NOT NULL,
    "city" VARCHAR(50),
    "province" VARCHAR(50),
    "owner_name" VARCHAR(50)
);

-- Create Customer table
CREATE TABLE "Customer" (
    "customer_id" SERIAL PRIMARY KEY,
    "home_id" INT NOT NULL,
    "first_name" VARCHAR(20) NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "password" VARCHAR(50) NOT NULL,
    "access_level" VARCHAR(20) NOT NULL,
    CONSTRAINT "FK_User" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE
);

-- Create Device table
CREATE TABLE "Device" (
    "device_id" VARCHAR(50) PRIMARY KEY,
    "home_id" INT NOT NULL,
    "device_name" VARCHAR(50) NOT NULL,
    "device_type" VARCHAR(10) NOT NULL,
    "manufacturer" VARCHAR(50),
    "installation_date" DATE,
    CONSTRAINT "FK_Device" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE,
    CONSTRAINT "CHK_DeviceType" CHECK ("device_type" IN ('other', 'lock', 'sensor', 'camera', 'light'))
);

-- Create Schedule table
CREATE TABLE "Schedule" (
    "schedule_id" SERIAL PRIMARY KEY,
    "device_id" VARCHAR(50) NOT NULL,
    "start_time" TIMESTAMP NOT NULL,
    "end_time" TIMESTAMP NOT NULL,
    "action" VARCHAR(50),
    CONSTRAINT "FK_Schedule" FOREIGN KEY ("device_id") REFERENCES "Device" ("device_id") ON DELETE CASCADE
);

-- Create Alert table
CREATE TABLE "Alert" (
    "alert_id" SERIAL PRIMARY KEY,
    "home_id" INT NOT NULL,
    "device_id" VARCHAR(50) NOT NULL,
    "alert_type" VARCHAR(50),
    "alert_message" VARCHAR(50),
    "alert_time" TIMESTAMP,
    CONSTRAINT "FK_Alert" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE
);

-- Add check constraint on Device table (similar to SQL Server)
ALTER TABLE "Device"
    ADD CONSTRAINT "CHK_DeviceType" CHECK ("device_type" IN ('other', 'lock', 'sensor', 'camera', 'light'));

-- Add foreign key constraints (similar to SQL Server)
ALTER TABLE "Alert"
    ADD CONSTRAINT "FK_Alert" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE;

ALTER TABLE "Customer"
    ADD CONSTRAINT "FK_User" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE;

ALTER TABLE "Device"
    ADD CONSTRAINT "FK_Device" FOREIGN KEY ("home_id") REFERENCES "Home" ("home_id") ON DELETE CASCADE;

ALTER TABLE "Schedule"
    ADD CONSTRAINT "FK_Schedule" FOREIGN KEY ("device_id") REFERENCES "Device" ("device_id") ON DELETE CASCADE;
