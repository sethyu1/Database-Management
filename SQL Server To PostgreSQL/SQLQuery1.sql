--Remove MS SQL specific statements (i.e. “SET ANSI_NULLS ON”, “SET QUOTED_IDENTIFIER ON”, “SET ANSI_PADDING ON”)
--Replace square brackets around database object names by double quotes
--Remove square brackets around types
--Force to lowercase
--Replace default MS SQL schema “dbo” by PostgreSQL “public”
--Remove all non-supported optional keywords (i.e. “WITH NOCHECK”, “CLUSTERED”)
--Remove all reference to filegroup (i.e. “ON PRIMARY”)
--Replace types “INT IDENTITY(…)” by “SERIAL”
--Update all non-supported data types (i.e. “DATETIME” becomes “TIMESTAMP”, “MONEY” becomes NUMERIC(19,4))
--Replace the MS SQL query terminator “GO” with the PostgreSQL one “;”

-- USE statement removed (not applicable in PostgreSQL)

-- Table: "Alert"
CREATE TABLE "public"."Alert"(
	"alert_id" SERIAL NOT NULL,
	"home_id" INTEGER NOT NULL,
	"device_id" VARCHAR(50) NOT NULL,
	"alert_type" VARCHAR(50),
	"alert_message" VARCHAR(50),
	"alert_time" TIMESTAMP,
 CONSTRAINT "PK_Alert" PRIMARY KEY ("alert_id")
);

-- Table: "Customer"
CREATE TABLE "public"."Customer"(
	"customer_id" INTEGER NOT NULL,
	"home_id" INTEGER NOT NULL,
	"first_name" VARCHAR(20) NOT NULL,
	"last_name" VARCHAR(20) NOT NULL,
	"password" VARCHAR(50) NOT NULL,
	"access_level" VARCHAR(20) NOT NULL,
 CONSTRAINT "PK_User" PRIMARY KEY ("customer_id")
);

-- Table: "Device"
CREATE TABLE "public"."Device"(
	"device_id" VARCHAR(50) NOT NULL,
	"home_id" INTEGER NOT NULL,
	"device_name" VARCHAR(50) NOT NULL,
	"device_type" VARCHAR(10) NOT NULL,
	"manufacturer" VARCHAR(50),
	"installation_date" DATE,
 CONSTRAINT "PK_Device" PRIMARY KEY ("device_id")
);

-- Table: "Home"
CREATE TABLE "public"."Home"(
	"home_id" INTEGER NOT NULL,
	"address" VARCHAR(50) NOT NULL,
	"city" VARCHAR(50),
	"province" VARCHAR(50),
	"owner_name" VARCHAR(50),
 CONSTRAINT "PK_Home" PRIMARY KEY ("home_id")
);

-- Table: "Schedule"
CREATE TABLE "public"."Schedule"(
	"schedule_id" SERIAL NOT NULL,
	"device_id" VARCHAR(50) NOT NULL,
	"start_time" TIMESTAMP NOT NULL,
	"end_time" TIMESTAMP NOT NULL,
	"action" VARCHAR(50),
 CONSTRAINT "PK_Schedule" PRIMARY KEY ("schedule_id")
);

-- Foreign key constraints
ALTER TABLE "public"."Alert"
	ADD CONSTRAINT "FK_Alert" FOREIGN KEY("home_id")
	REFERENCES "public"."Home" ("home_id")
	ON DELETE CASCADE;

ALTER TABLE "public"."Customer"
	ADD CONSTRAINT "FK_User" FOREIGN KEY("home_id")
	REFERENCES "public"."Home" ("home_id")
	ON DELETE CASCADE;

ALTER TABLE "public"."Device"
	ADD CONSTRAINT "FK_Device" FOREIGN KEY("home_id")
	REFERENCES "public"."Home" ("home_id")
	ON DELETE CASCADE;

ALTER TABLE "public"."Schedule"
	ADD CONSTRAINT "FK_Schedule" FOREIGN KEY("device_id")
	REFERENCES "public"."Device" ("device_id")
	ON DELETE CASCADE;

-- Check constraints
ALTER TABLE "public"."Device"
	ADD CONSTRAINT "CHK_DeviceType" CHECK ("device_type"='other' OR "device_type"='lock' OR "device_type"='sensor' OR "device_type"='camera' OR "device_type"='light');

-- GO statements removed; use semicolon (;) as statement terminator
