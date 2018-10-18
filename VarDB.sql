USE master
go

IF EXISTS(SELECT name FROM sys.databases
	WHERE name = 'VarDB')
DROP DATABASE VarDB
GO

create database [VarDB]
	
	go

	use [VarDB]

	go

	CREATE TABLE [dbo].[tbPatient](

		[ID] [int] IDENTITY(1,1) NOT NULL,
		[ID1Paciente] [int] default (11) not null,
		[ID2Paciente] [int] default (22) not null,
		[Gender] [char] default('M') not null,
		[FirstName] [nvarchar](30) default ('') not NULL,
		[LastName] [nvarchar](30) default ('') not NULL,
		[BirthDate] [date] default ('') not null,
		[RadOnc] [nvarchar] (100) default ('') not null,
		BLOBImage varBinary(MAX),
		constraint pk_tbPatient_id primary key (ID),
		)


	create table [dbo].[tbPlan] (

		[ID] [int] IDENTITY(1,1) NOT NULL,
		[Approved] bit default (1) not null,
		[Description] [nvarchar] (100) default('') not null,
		constraint pk_tbPlan_id primary key (ID),

		)

	create table [dbo].[tbCourse] (

		[ID] [int] IDENTITY (1,1) NOT NULL,
		[Description] [nvarchar] (100) default('') not null,
		constraint pk_tbCourse_id primary key (ID),

		)

	create table [dbo].[tbRCoursePlan] (
		[ID] [int] IDENTITY (1,1) NOT NULL,
		[IDPlan] int default (1) not null,
		[IDCourse] int default (1) not null,

		constraint pk_tbRCoursePlan_id primary key (ID),
		constraint fk_tbRCoursePlan_Plan foreign key (IDPlan) references tbPlan (ID),
		constraint fk_tbRCoursePlan_Course foreign key (IDCourse) references tbCourse (ID),

		)

	create table [dbo].[tbRPatientCourse] (
		[ID] [int] IDENTITY (1,1) NOT NULL,
		[IDPatient] int default (1) not null,
		[IDCourse] int default (1) not null,

		constraint pk_tbRPatientCourse_id primary key (ID),
		constraint fk_tbRPatientCourse_Patient foreign key (IDPatient) references tbPatient (ID),
		constraint fk_tbRPatientCourse_Course foreign key (IDCourse) references tbCourse (ID),

		)

	create table [dbo].[tbAppointment] (

		[ID] [int] IDENTITY (1,1) not null,
		[AppointmentDate] date default ('')not null,
		[Description] [nvarchar] (100) default('') not null,
		[IDPatientCourse] int default (0) not null,
		constraint pk_tbAppointment_id primary key (ID),
		constraint fk_tbAppointment_PatientCourse foreign key ([IDPatientCourse]) references tbRPatientCourse (ID),
		)

	go

	insert into tbPatient (FirstName, LastName,Gender,BLOBImage) values ('Lois' , 'Griffin','F',(SELECT * FROM Openrowset(Bulk 'C:/VarTEMP/lois.jpg', SINGLE_BLOB) AS l))
		insert into tbPatient (FirstName, LastName,BLOBImage) values ('Chris' , 'Griffin',(SELECT * FROM Openrowset(Bulk 'C:/VarTEMP/chris.jpg', SINGLE_BLOB) AS c))
			insert into tbPatient (FirstName, LastName,Gender,BLOBImage) values ('Brian' , 'Griffin','D',(SELECT * FROM Openrowset(Bulk 'C:/VarTEMP/brian.jpg', SINGLE_BLOB) AS b))

				insert into tbPlan (Description) values ('Plano 1')
					insert into tbPlan (Description) values ('Plano 2')
						insert into tbPlan (Description) values ('Plano 3')
							insert into tbPlan (Description,Approved) values ('Plano 4',0)

								insert into tbCourse (Description) values ('Course 1')
									insert into tbCourse (Description) values ('Course 2')
										insert into tbCourse (Description) values ('Course 3')

											insert into tbRCoursePlan (IDCourse,IDPlan) values (2,1)
												insert into tbRCoursePlan (IDCourse,IDPlan) values (2,4)
													insert into tbRCoursePlan (IDCourse,IDPlan) values (2,2)

														insert into tbRPatientCourse (IDPatient,IDCourse) values (2,2)

															insert into tbAppointment (Description,AppointmentDate,IDPatientCourse) values ('Appointment 1',GETDATE(),1)
