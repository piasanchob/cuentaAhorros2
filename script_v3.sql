USE [master]
GO
/****** Object:  Database [cuentaAhorros]    Script Date: 20/10/2021 14:30:07 ******/
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
/****** Object:  User [sa2]    Script Date: 20/10/2021 14:30:08 ******/
CREATE USER [sa2] FOR LOGIN [sa2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Beneficiarios]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdParentesco] [int] NOT NULL,
	[IdPersona] [int] NULL,
	[Porcentaje] [int] NOT NULL,
	[NumCuenta] [varchar](64) NOT NULL,
	[Activo] [bit] NULL,
	[FechaEliminacion] [date] NULL,
 CONSTRAINT [PK_Beneficiarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaAhorros]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaAhorros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[IdTipoCuenta] [int] NOT NULL,
	[IdUsuario] [int] NULL,
	[IdMovimiento] [int] NULL,
	[ValorDocIdentidad] [int] NULL,
	[NumCuenta] [varchar](64) NOT NULL,
	[Saldo] [float] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
 CONSTRAINT [PK_CuentaAhorros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaObjetivo]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaObjetivo](
	[Id] [int] NOT NULL,
	[IdCuentaAhorros] [int] NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[Cuota] [int] NOT NULL,
	[Objetivo] [int] NOT NULL,
	[Saldo] [int] NOT NULL,
	[InteresAcumulado] [nchar](10) NOT NULL,
 CONSTRAINT [PK_CuentaObjetivo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[Movimientos]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[Id] [int] NOT NULL,
	[IdTipoMov] [int] NULL,
	[IdTipoCambio] [int] NULL,
	[Fecha] [datetime] NOT NULL,
	[Monto] [float] NOT NULL,
	[NuevoSaldo] [float] NOT NULL,
	[MontoMonedaOriginal] [int] NULL,
	[MontoMonedaCuenta] [int] NULL,
	[Descripcion] [varchar](64) NULL,
	[IdMoneda] [int] NULL,
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parentescos]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[Personas]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[TipoCambio]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[TipoDocsIdentidad]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[TipoMonedas]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[TipoMov]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMov](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoMov] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCuentaAhorros]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[UsuarioPuedeVer]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 20/10/2021 14:30:09 ******/
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
ALTER TABLE [dbo].[CuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorros_Beneficiarios] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Beneficiarios] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorros] CHECK CONSTRAINT [FK_CuentaAhorros_Beneficiarios]
GO
ALTER TABLE [dbo].[CuentaAhorros]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorros_Movimientos] FOREIGN KEY([IdMovimiento])
REFERENCES [dbo].[Movimientos] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorros] CHECK CONSTRAINT [FK_CuentaAhorros_Movimientos]
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
/****** Object:  StoredProcedure [dbo].[ActualizarDatos]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarDatos] @Porcentaje INT, @Parentesco VARCHAR(64),
@Nombre VARCHAR(64), @Cedula VARCHAR(64), 
@CedulaB VARCHAR(64)
AS
	BEGIN
		DECLARE @P INT;
		IF (@Parentesco='Padre')
			SET @P=1;
		IF (@Parentesco='Madre')
			SET @P=2;
		IF (@Parentesco='Hijo')
			SET @P=3;
		IF (@Parentesco='Hija')
			SET @P=4;
		IF (@Parentesco='Hermano')
			SET @P=5;
		IF (@Parentesco='Hermana')
			SET @P=6;
		IF (@Parentesco='Amigo')
			SET @P=7;
		IF (@Parentesco='Amiga')
			SET @P=8;

		UPDATE dbo.Beneficiarios
		SET IdParentesco=@P,Porcentaje=@Porcentaje WHERE @Cedula = Cedula;

		UPDATE dbo.Personas
		SET Nombre=@Nombre WHERE Cedula = @CedulaB;

		
END;
GO
/****** Object:  StoredProcedure [dbo].[agregarBeneficiario]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[agregarBeneficiario]  @Parentezco VARCHAR(64),
@Porcentaje INT,  @ident VARCHAR(64),@Cuenta VARCHAR(64)
AS
	BEGIN
	DECLARE @P INT;
		IF (@Parentezco='Padre')
			SET @P=1;
		IF (@Parentezco='Madre')
			SET @P=2;
		IF (@Parentezco='Hijo')
			SET @P=3;
		IF (@Parentezco='Hija')
			SET @P=4;
		IF (@Parentezco='Hermano')
			SET @P=5;
		IF (@Parentezco='Hermana')
			SET @P=6;
		IF (@Parentezco='Amigo')
			SET @P=7;
		IF (@Parentezco='Amiga')
			SET @P=8;

		INSERT INTO dbo.Beneficiarios (IdParentesco,Porcentaje,Cedula,NumCuenta)
		VALUES (@P,@Porcentaje,@ident,@Cuenta);

END;
GO
/****** Object:  StoredProcedure [dbo].[agregarPersona]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[agregarPersona] @Nombre VARCHAR(64), @Fecha DATE, 
@ident INT, @tel1 VARCHAR(64),@tel2 VARCHAR(64), 
@Email VARCHAR(64)
AS
	
	BEGIN


		INSERT INTO dbo.Personas(Cedula,Nombre,FechaNac,Tel1,Tel2,Email)
		VALUES (@ident,@Nombre,@Fecha,@tel1,@tel2,@Email);

END;
GO
/****** Object:  StoredProcedure [dbo].[Eliminar]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Eliminar] @Cedula VARCHAR(64)
AS
	BEGIN
		UPDATE dbo.Beneficiarios
		SET Porcentaje=0 , Activo=0 , FechaEliminacion=GETDATE() 
		WHERE @Cedula = Cedula;
END;
GO
/****** Object:  StoredProcedure [dbo].[eliminarBeneficiario]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[eliminarBeneficiario] @Cedula VARCHAR(64)
AS
	
	BEGIN
	DECLARE @Var AS VARCHAR(64);

	SELECT  dbo.Beneficiarios.Activo FROM  dbo.Beneficiarios WHERE dbo.Beneficiarios.Cedula=@Cedula;


		
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarTablas]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarTablas]
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
EXEC EliminarTablas;
GO
/****** Object:  StoredProcedure [dbo].[EliminarXML]    Script Date: 20/10/2021 14:30:09 ******/
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
/****** Object:  StoredProcedure [dbo].[numeroCuentas]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[numeroCuentas] @Cedula VARCHAR(64)
As
	BEGIN

		SELECT NumCuenta FROM Beneficiarios WHERE Cedula=@Cedula;
END;
GO
/****** Object:  StoredProcedure [dbo].[ValidarBeneficiarios]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidarBeneficiarios] @Cedula VARCHAR(64)
AS
	BEGIN

		IF ((SELECT count(Cedula) FROM beneficiarios WHERE Cedula=@Cedula )<3)
			RETURN 1;
		ELSE
			RETURN 0;
END;
GO
/****** Object:  StoredProcedure [dbo].[ValidarEdit]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidarEdit] @cedula VARCHAR(64), @cedulaB VARCHAR(64)
As
	BEGIN
		IF (EXISTS (SELECT 1 FROM dbo.Personas WHERE  Cedula = @cedulaB) )
			IF (EXISTS (SELECT 1 FROM dbo.Beneficiarios WHERE cedula = @cedula))
					
					RETURN 1;
		ELSE
			RETURN 0;
END;
GO
/****** Object:  StoredProcedure [dbo].[ValidarElim]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidarElim] @cedula VARCHAR(64), @porcentaje VARCHAR(64), @numCuenta VARCHAR(64)
As
	BEGIN
		IF (EXISTS (SELECT 1 FROM dbo.Personas WHERE Cedula = @cedula) )
			IF (EXISTS (SELECT 1 FROM dbo.CuentaAhorros WHERE NumCuenta = @NumCuenta) )
				IF (EXISTS (SELECT 1 FROM dbo.Beneficiarios WHERE Porcentaje = @Porcentaje))
					
					RETURN 1;
		ELSE
			RETURN 0;
			

END;
GO
/****** Object:  StoredProcedure [dbo].[validarIdenPersona]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validarIdenPersona] @ident VARCHAR(64)
AS
	BEGIN
		
		IF (EXISTS (SELECT 1 FROM dbo.Personas WHERE Cedula = @ident))
			RETURN  1;
		ELSE
			RETURN  0;
		
END;
GO
/****** Object:  StoredProcedure [dbo].[validarIdentificacion]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validarIdentificacion] @ident VARCHAR(64)
AS
	BEGIN
		
		IF (EXISTS (SELECT 1 FROM dbo.Beneficiarios WHERE Cedula = @ident))
			RETURN  1;
		ELSE
			RETURN  0;
		
END;
GO
/****** Object:  StoredProcedure [dbo].[validarPorcentaje]    Script Date: 20/10/2021 14:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validarPorcentaje] @Porcentaje2 INT , @Cedula VARCHAR(64)
As
	BEGIN
		DECLARE @Val AS INT;
		DECLARE @Sum AS INT;

		SET @Val = (SELECT SUM(Porcentaje) FROM dbo.Beneficiarios WHERE @Cedula=Cedula);

		SET @Sum = @Porcentaje2 + @Val;
		
		IF (@Sum<100)
			RETURN 1;
		ELSE IF (@Sum>100)
			RETURN 0;
		ELSE 
			RETURN 10;
		
END;
GO
/****** Object:  StoredProcedure [dbo].[validarUsuario]    Script Date: 20/10/2021 14:30:09 ******/
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
