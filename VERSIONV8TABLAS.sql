USE [master]
GO
/****** Object:  Database [cuentaAhorros]    Script Date: 10/22/2021 2:33:56 AM ******/
CREATE DATABASE [cuentaAhorros]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cuentaAhorros', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\cuentaAhorros.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cuentaAhorros_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\cuentaAhorros_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [cuentaAhorros] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cuentaAhorros].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cuentaAhorros] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cuentaAhorros] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cuentaAhorros] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cuentaAhorros] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cuentaAhorros] SET ARITHABORT OFF 
GO
ALTER DATABASE [cuentaAhorros] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cuentaAhorros] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cuentaAhorros] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cuentaAhorros] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cuentaAhorros] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cuentaAhorros] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cuentaAhorros] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cuentaAhorros] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cuentaAhorros] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cuentaAhorros] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cuentaAhorros] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cuentaAhorros] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cuentaAhorros] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cuentaAhorros] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cuentaAhorros] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cuentaAhorros] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cuentaAhorros] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cuentaAhorros] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [cuentaAhorros] SET  MULTI_USER 
GO
ALTER DATABASE [cuentaAhorros] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cuentaAhorros] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cuentaAhorros] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cuentaAhorros] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [cuentaAhorros] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [cuentaAhorros] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'cuentaAhorros', N'ON'
GO
ALTER DATABASE [cuentaAhorros] SET QUERY_STORE = OFF
GO
USE [cuentaAhorros]
GO
/****** Object:  Table [dbo].[Beneficiarios]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdParentesco] [int] NOT NULL,
	[IdPersona] [int] NULL,
	[Porcentaje] [int] NOT NULL,
	[IdNumCuenta] [int] NOT NULL,
	[Activo] [bit] NULL,
	[FechaEliminacion] [date] NULL,
 CONSTRAINT [PK_Beneficiarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaAhorros]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaAhorros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[IdTipoCuenta] [int] NULL,
	[IdUsuario] [int] NULL,
	[NumCuenta] [varchar](64) NOT NULL,
	[Saldo] [float] NOT NULL,
	[FechaCreacion] [date] NULL,
 CONSTRAINT [PK_CuentaAhorros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaObjetivo]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaObjetivo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCuentaAhorros] [int] NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[Cuota] [int] NOT NULL,
	[Objetivo] [int] NOT NULL,
	[Saldo] [int] NOT NULL,
	[InteresAcumulado] [int] NOT NULL,
	[Descripcion] [varchar](64) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_CuentaObjetivo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCuenta](
	[Id] [int] NOT NULL,
	[IdCuentaAhorros] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[SaldoInicial] [float] NOT NULL,
	[SaldoFinal] [float] NOT NULL,
 CONSTRAINT [PK_EstadoCuenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoMov] [int] NULL,
	[IdTipoCambio] [int] NULL,
	[Fecha] [datetime] NULL,
	[Monto] [float] NOT NULL,
	[NuevoSaldo] [float] NULL,
	[MontoMonedaOriginal] [int] NULL,
	[MontoMonedaCuenta] [int] NULL,
	[Descripcion] [varchar](64) NULL,
	[IdMoneda] [int] NULL,
	[IdCuenta] [int] NULL,
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parentescos]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parentescos](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Parentescos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoDoc] [int] NULL,
	[ValorDocIdentidad] [varchar](20) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[FechaNac] [date] NOT NULL,
	[Tel1] [bigint] NOT NULL,
	[Tel2] [bigint] NULL,
	[Email] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCambio]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCambio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMoneda] [int] NULL,
	[IdOtra] [int] NULL,
	[TCCompra] [int] NOT NULL,
	[TCVenta] [int] NOT NULL,
	[Fecha] [date] NULL,
 CONSTRAINT [PK_TipoCambio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocsIdentidad]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDocsIdentidad](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoCedulas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMonedas]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMonedas](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoMonedas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMov]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMov](
	[Id] [int] NOT NULL,
	[Operacion] [varchar](64) NULL,
	[Descripcion] [varchar](64) NULL,
 CONSTRAINT [PK_TipoMov] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCuentaAhorros]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCuentaAhorros](
	[Id] [int] NOT NULL,
	[IdTipoMoneda] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[SaldoMin] [float] NOT NULL,
	[MultaSaldoMin] [float] NOT NULL,
	[CargoAnual] [int] NOT NULL,
	[NumRetirosHumano] [int] NOT NULL,
	[NumRetirosAutomatico] [int] NOT NULL,
	[ComisionHumano] [int] NOT NULL,
	[ComisionCajero] [int] NOT NULL,
	[TasaInteres] [int] NOT NULL,
 CONSTRAINT [PK_TiposCuentaAhorros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioPuedeVer]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPuedeVer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[Username] [varchar](64) NOT NULL,
	[NumCuenta] [varchar](64) NOT NULL,
 CONSTRAINT [PK_UsuarioPuedeVer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ValorDocIdentidad] [varchar](64) NOT NULL,
	[Username] [varchar](64) NOT NULL,
	[Pass] [varchar](64) NOT NULL,
	[EsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Usuarios_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_CuentaAhorros] FOREIGN KEY([IdNumCuenta])
REFERENCES [dbo].[CuentaAhorros] ([Id])
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_CuentaAhorros]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_Parentescos1] FOREIGN KEY([IdParentesco])
REFERENCES [dbo].[Parentescos] ([Id])
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_Parentescos1]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_Personas] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Personas] ([Id])
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_Personas]
GO
ALTER TABLE [dbo].[CuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorros_Personas] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Personas] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorros] CHECK CONSTRAINT [FK_CuentaAhorros_Personas]
GO
ALTER TABLE [dbo].[CuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorros_TiposCuentaAhorros1] FOREIGN KEY([IdTipoCuenta])
REFERENCES [dbo].[TiposCuentaAhorros] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorros] CHECK CONSTRAINT [FK_CuentaAhorros_TiposCuentaAhorros1]
GO
ALTER TABLE [dbo].[CuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorros_UsuarioPuedeVer] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[UsuarioPuedeVer] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorros] CHECK CONSTRAINT [FK_CuentaAhorros_UsuarioPuedeVer]
GO
ALTER TABLE [dbo].[CuentaObjetivo]  WITH CHECK ADD  CONSTRAINT [FK_CuentaObjetivo_CuentaAhorros] FOREIGN KEY([IdCuentaAhorros])
REFERENCES [dbo].[CuentaAhorros] ([Id])
GO
ALTER TABLE [dbo].[CuentaObjetivo] CHECK CONSTRAINT [FK_CuentaObjetivo_CuentaAhorros]
GO
ALTER TABLE [dbo].[EstadoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_EstadoCuenta_CuentaAhorros] FOREIGN KEY([IdCuentaAhorros])
REFERENCES [dbo].[CuentaAhorros] ([Id])
GO
ALTER TABLE [dbo].[EstadoCuenta] CHECK CONSTRAINT [FK_EstadoCuenta_CuentaAhorros]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_CuentaAhorros] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[CuentaAhorros] ([Id])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_CuentaAhorros]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_TipoCambio] FOREIGN KEY([IdTipoCambio])
REFERENCES [dbo].[TipoCambio] ([Id])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_TipoCambio]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_TipoMonedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[TipoMonedas] ([Id])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_TipoMonedas]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_TipoMov] FOREIGN KEY([IdTipoMov])
REFERENCES [dbo].[TipoMov] ([Id])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_TipoMov]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_TipoCedulas] FOREIGN KEY([IdTipoDoc])
REFERENCES [dbo].[TipoDocsIdentidad] ([Id])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_TipoCedulas]
GO
ALTER TABLE [dbo].[TipoCambio]  WITH CHECK ADD  CONSTRAINT [FK_TipoCambio_TipoMonedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[TipoMonedas] ([Id])
GO
ALTER TABLE [dbo].[TipoCambio] CHECK CONSTRAINT [FK_TipoCambio_TipoMonedas]
GO
ALTER TABLE [dbo].[TipoCambio]  WITH CHECK ADD  CONSTRAINT [FK_TipoCambio_TipoMonedas1] FOREIGN KEY([IdOtra])
REFERENCES [dbo].[TipoMonedas] ([Id])
GO
ALTER TABLE [dbo].[TipoCambio] CHECK CONSTRAINT [FK_TipoCambio_TipoMonedas1]
GO
ALTER TABLE [dbo].[TiposCuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_TiposCuentaAhorros_TipoMonedas] FOREIGN KEY([IdTipoMoneda])
REFERENCES [dbo].[TipoMonedas] ([Id])
GO
ALTER TABLE [dbo].[TiposCuentaAhorros] CHECK CONSTRAINT [FK_TiposCuentaAhorros_TipoMonedas]
GO
ALTER TABLE [dbo].[UsuarioPuedeVer]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioPuedeVer_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[UsuarioPuedeVer] CHECK CONSTRAINT [FK_UsuarioPuedeVer_Usuarios]
GO
/****** Object:  StoredProcedure [dbo].[AgregarCuentaObjetivo]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarCuentaObjetivo]
	@InNumCuenta INT,
	@InFechaInicio DATE,
	@InFechaFinal DATE,
	@InCuota INT,
	@InObjetivo INT,
	@InSaldo INT,
	@InInteresAcumulado INT,
	@InDescripcion VARCHAR(64),
	@InActivo BIT,
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdNumCuenta INT
		
		BEGIN TRANSACTION T1

			SET @IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);

			INSERT INTO dbo.CuentaObjetivo(IdCuentaAhorros,
			
			FechaInicio,
			FechaFinal,
			Cuota,
			Objetivo,
			Saldo,
			InteresAcumulado,
			Descripcion,
			Activo)
			

			VALUES(
			@IdNumCuenta,
			@InFechaInicio,
			@InFechaFinal,
			@InCuota,
			@InObjetivo,
			@InSaldo,
			@InInteresAcumulado,
			@InDescripcion,
			@InActivo )

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[EditarCuentaObjetivo]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[EditarCuentaObjetivo]
	@InNumCuenta INT,
	@InFechaInicio DATE,
	@InFechaFinal DATE,
	@InCuota INT,
	@InObjetivo INT,
	@InDescripcion VARCHAR(64),
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdCuentaAhorros INT
		
		BEGIN TRANSACTION T1

			SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);



			UPDATE CuentaObjetivo 

			SET FechaInicio=@InFechaInicio,
			 FechaFinal=@InFechaFinal,
			 Cuota=@InCuota ,
			 Objetivo =@InObjetivo ,
			 Descripcion= @InDescripcion
			

			WHERE @IdCuentaAhorros=Id;

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarCuentaObjetivo]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarCuentaObjetivo]
	@InNumCuenta INT,
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdCuentaAhorros INT
		
		BEGIN TRANSACTION T1

			SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);

			UPDATE CuentaObjetivo 
			SET Activo=0

			WHERE @IdCuentaAhorros=Id;

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarXML]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarXML]
AS
	BEGIN
	DELETE FROM dbo.Personas;
	DBCC CHECKIDENT ('[Personas]', RESEED, 0);
	SELECT * FROM dbo.Personas;
	DELETE FROM dbo.TipoDocsIdentidad;
	DBCC CHECKIDENT ('[TipoDocsIdentidad]', RESEED, 0);
	SELECT * FROM dbo.TipoDocsIdentidad;
	DELETE FROM dbo.CuentaAhorros;
	DBCC CHECKIDENT ('[CuentaAhorros]', RESEED, 0);
	SELECT * FROM dbo.CuentaAhorros;
	DELETE FROM dbo.TiposCuentaAhorros
	DBCC CHECKIDENT ('[TiposCuentaAhorros]', RESEED, 0);
	SELECT * FROM dbo.TiposCuentaAhorros;
	DELETE FROM dbo.TipoMonedas
	DBCC CHECKIDENT ('[TipoMonedas]', RESEED, 0);
	SELECT * FROM dbo.TipoMonedas;
	DELETE FROM dbo.Beneficiarios
	DBCC CHECKIDENT ('[Beneficiarios]', RESEED, 0);
	SELECT * FROM dbo.Beneficiarios;
	DELETE FROM dbo.Parentescos
	DBCC CHECKIDENT ('[Parentescos]', RESEED, 0);
	SELECT * FROM dbo.Parentescos;
	DELETE FROM dbo.Usuarios
	DBCC CHECKIDENT ('[Usuarios]', RESEED, 0);
	SELECT * FROM dbo.Usuarios;
	DELETE FROM dbo.UsuarioPuedeVer;
	DBCC CHECKIDENT ('[UsuarioPuedeVer]', RESEED, 0);
	SELECT * FROM dbo.UsuarioPuedeVer;
END;
GO
/****** Object:  StoredProcedure [dbo].[MostrarEstadosCuenta]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostrarEstadosCuenta]
	@InNumCuenta int,
	@OutCodeResult int
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdNumCuenta int
		
		BEGIN TRANSACTION T1

			SET @IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta)-- ORDER BY

			SELECT * FROM EstadoCuenta WHERE IdCuentaAhorros = @IdNumCuenta;
		
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[MostrarNumCuentas]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostrarNumCuentas]
	@InDocIdentidad int,
	@OutCodeResult int
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdPersona INT,
			@IdNumCuenta INT

		
		BEGIN TRANSACTION T1

			SET @IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = @InDocIdentidad)-- ORDER BY

			SELECT * FROM CuentaAhorros WHERE IdPersona= @IdPersona

		
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[validarUsuario]    Script Date: 10/22/2021 2:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validarUsuario] @Usuario VARCHAR(64), @Contra VARCHAR(64)
AS
  DECLARE @returnVal AS INT;
	BEGIN
		
		IF (EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = @Usuario AND Pass = @Contra ))
			 
			RETURN  1;
		ELSE
			
			RETURN  0;
		
END;
GO
USE [master]
GO
ALTER DATABASE [cuentaAhorros] SET  READ_WRITE 
GO
