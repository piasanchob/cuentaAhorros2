USE [master]
GO
/****** Object:  Database [cuentaAhorros]    Script Date: 10/26/2021 11:48:54 PM ******/
CREATE DATABASE [cuentaAhorros]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cuentaAhorros', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\cuentaAhorros.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cuentaAhorros_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\cuentaAhorros_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Beneficiarios]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[CuentaAhorros]    Script Date: 10/26/2021 11:48:55 PM ******/
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
	[Saldo] [float] NULL,
	[FechaCreacion] [date] NULL,
 CONSTRAINT [PK_CuentaAhorros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaObjetivo]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCuenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCuentaAhorros] [int] NOT NULL,
	[FechaInicio] [date] NULL,
	[FechaFinal] [date] NULL,
	[SaldoInicial] [int] NULL,
	[CantOpHumano] [int] NULL,
	[CantOpATM] [int] NULL,
	[SaldoFinal] [float] NULL,
 CONSTRAINT [PK_EstadoCuenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[Parentescos]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[Personas]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[TipoCambio]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[TipoDocsIdentidad]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[TipoMonedas]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[TipoMov]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[TiposCuentaAhorros]    Script Date: 10/26/2021 11:48:55 PM ******/
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
	[CargoMensual] [int] NOT NULL,
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
/****** Object:  Table [dbo].[UsuarioPuedeVer]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarDatos]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarDatos] @InPorcentaje INT, @InParentesco VARCHAR(64),
@InNombre VARCHAR(64), 
@InCedula VARCHAR(64), 
@InCedulaB VARCHAR(64),
@OutCodeResult INT

AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @P INT
		DECLARE @Var INT

		IF (@InParentesco='Padre')
			SET @P=1;
		IF (@InParentesco='Madre')
			SET @P=2;
		IF (@InParentesco='Hijo')
			SET @P=3;
		IF (@InParentesco='Hija')
			SET @P=4;
		IF (@InParentesco='Hermano')
			SET @P=5;
		IF (@InParentesco='Hermana')
			SET @P=6;
		IF (@InParentesco='Amigo')
			SET @P=7;
		IF (@InParentesco='Amiga')
			SET @P=8;
		SET @Var = (SELECT Id FROM Personas WHERE ValorDocIdentidad=@InCedula)

		UPDATE dbo.Beneficiarios
		SET IdParentesco=@P,Porcentaje=@InPorcentaje WHERE IdPersona = @Var;

		UPDATE dbo.Personas
		SET Nombre=@InNombre WHERE ValorDocIdentidad = @InCedulaB;
		
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
/****** Object:  StoredProcedure [dbo].[agregarBeneficiario]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[agregarBeneficiario] 
@InParentezco VARCHAR(64),
@InPorcentaje INT, 
@InIdent VARCHAR(64),
@InCuenta VARCHAR(64),
@OutCodeResult INT

AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY

		DECLARE @P INT;
		DECLARE @Var INT;
		Declare @IdNumCuenta INT ;

		IF (@InParentezco='Padre')
			SET @P=1;
		IF (@InParentezco='Madre')
			SET @P=2;
		IF (@InParentezco='Hijo')
			SET @P=3;
		IF (@InParentezco='Hija')
			SET @P=4;
		IF (@InParentezco='Hermano')
			SET @P=5;
		IF (@InParentezco='Hermana')
			SET @P=6;
		IF (@InParentezco='Amigo')
			SET @P=7;
		IF (@InParentezco='Amiga')
			SET @P=8;

		SET @Var = (SELECT Id FROM Personas WHERE ValorDocIdentidad=@InIdent)


		SET @IdNumCuenta = (SELECT IdNumCuenta FROM Beneficiarios WHERE id=@Var)

		INSERT INTO dbo.Beneficiarios (IdParentesco,Porcentaje,IdPersona,IdNumCuenta)
		VALUES (@P,@InPorcentaje,@Var,@IdNumCuenta);


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
/****** Object:  StoredProcedure [dbo].[AgregarCuentaObjetivo]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[agregarPersona]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[agregarPersona] @InNombre VARCHAR(64), 
@InFecha DATE, 
@InIdent INT, 
@InTel1 VARCHAR(64),
@InTel2 VARCHAR(64), 
@InEmail VARCHAR(64),
@OutCodeResult INT
AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY


		INSERT INTO dbo.Personas(ValorDocIdentidad,Nombre,FechaNac,Tel1,Tel2,Email)
		VALUES (@InIdent,@InNombre,@InFecha,@InTel1,@InTel2,@InEmail);



		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF

END;
GO
/****** Object:  StoredProcedure [dbo].[EditarCuentaObjetivo]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[eliminarBeneficiario]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[eliminarBeneficiario] 
@InCedula VARCHAR(64),
@OutCodeResult INT
AS
	
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	DECLARE @Var VARCHAR(64);
	DECLARE @IdPersona INT;

	SET @IdPersona= (SELECT Id FROM Personas WHERE ValorDocIdentidad = @InCedula)
	SELECT  dbo.Beneficiarios.Activo FROM  dbo.Beneficiarios WHERE dbo.Beneficiarios.IdPersona= @IdPersona;

	COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
		
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarCuentaObjetivo]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarXML]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[EstadosDeCuenta]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EstadosDeCuenta]
@OutCodeResult INT
AS
	
DECLARE @cont INT=1, @IdCuentaAhorros INT, @IdEstadoCuenta INT, @IdTipoCuentaAhorro INT, 
@SaldoMin INT, @Saldo INT,@MultaSaldoMin INT, @SaldoFinal INT,@NumRetirosHumano INT,
@NumRetirosAutomatico INT, @ComisionRetiroHumano INT, @ComisionRetiroAutomatico INT,
@diferenciaRetirosHumano INT, @diferenciaRetirosATM INT, @ContRetiroAtm INT, 
@ContRetiroHumano INT, @TasaInteres INT, @Suma INT, @CargoMensual INT

WHILE @cont<25
	BEGIN


	SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE Id= @cont)
	-- SET IDCUENTA AHORRO DE LA TABLA ESTADO DE CUENTA 
	SET @IdEstadoCuenta = (SELECT Id FROM EstadoCuenta WHERE Id=@IdCuentaAhorros)

	SET @IdTipoCuentaAhorro =(SELECT IdTipoCuenta FROM cuentaAhorros WHERE Id=@IdCuentaAhorros)
	-- SET INTERES
	SET @TasaInteres = (SELECT TasaInteres FROM TiposCuentaAhorros WHERE  Id= @IdTipoCuentaAhorro)
	-- SET DE MULTAS
	SET @SaldoMin = (SELECT SaldoMin FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)




	SET @MultaSaldoMin = (SELECT MultaSaldoMin FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)



	SET @Saldo = (SELECT Saldo FROM cuentaAhorros WHERE Id = @IdCuentaAhorros )
	--CARGO MENSUAL 

	SET @CargoMensual = (SELECT CargoMensual FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)
	-- SET NUMEROS DE RETIROS DE LA TABLA TIPOS CUENTA AHORROS 

	SET @NumRetirosHumano = (SELECT NumRetirosHumano FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	SET @NumRetirosAutomatico=  (SELECT NumRetirosAutomatico FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	-- SET DE COMISIONES DE LA TABLA TIPOS CUENTA AHORROS
	SET @ComisionRetiroHumano = (SELECT ComisionHumano FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	SET @ComisionRetiroAutomatico=  (SELECT ComisionCajero FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	
	--SET RETIROS DE CAJERO DE LA TABLA ESTADO DE CUENTA 
	SET @ContRetiroAtm = (SELECT CantOpATM FROM EstadoCuenta WHERE IdCuentaAhorros = @IdCuentaAhorros)
	SET @ContRetiroHumano = (SELECT CantOpHumano FROM EstadoCuenta WHERE IdCuentaAhorros = @IdCuentaAhorros)

	SET @diferenciaRetirosHumano =  (@ContRetiroHumano - @NumRetirosHumano)

	SET @diferenciaRetirosATM = (@ContRetiroAtm- @NumRetirosAutomatico)

	UPDATE EstadoCuenta 
	SET SaldoInicial = @Saldo
	WHERE Id= @IdEstadoCuenta
	 

	IF @TasaInteres =10

		SET @Suma = @Saldo * 0.1
		SET @SaldoFinal = (@Saldo + @Suma)

	IF @TasaInteres = 15

		SET @Suma = @Saldo * 0.15
		SET @SaldoFinal = @Saldo + @Suma

	IF  @TasaInteres = 20
		SET @Suma = @Saldo * 0.2
		SET @SaldoFinal = @Saldo + @Suma




	IF @Saldo<=@SaldoMin 
		SET @SaldoFinal = @Saldo - @MultaSaldoMin


	IF (@diferenciaRetirosHumano >0)

		SET @SaldoFinal = @Saldo - (@diferenciaRetirosHumano * @ComisionRetiroHumano)

	IF (@diferenciaRetirosATM >0)

		SET @SaldoFinal = @Saldo - (@diferenciaRetirosATM * @ComisionRetiroAutomatico)



	SET @SaldoFinal = @Saldo - @CargoMensual


	UPDATE EstadoCuenta
	SET SaldoFinal=@SaldoFinal
	WHERE Id=@IdEstadoCuenta
SET @cont+=1

END;
GO
/****** Object:  StoredProcedure [dbo].[llenaEstadoCuentaCant]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[llenaEstadoCuentaCant]
AS
Declare @IdMov INT = 1, @IdTipoMov INT, @CantRetiroHumano INT, @CantRetiroAtm INT,
@IdCuenta INT, @IdEstadoCuenta INT, @FechaInicial DATE, @FechaFinal DATE

WHILE @IdMov<3564
BEGIN 
	SET @IdTipoMov =(SELECT IdTipoMov FROM Movimientos WHERE Id=@IdMov)
	SET @FechaInicial = (SELECT Fecha FROM Movimientos WHERE Id=@IdMov)
	SET @IdCuenta = (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)



	IF @IdTipoMov = 6
		UPDATE EstadoCuenta
		SET CantOpATM = CantOpATM + 1
		WHERE IdCuentaAhorros=@IdCuenta


	IF @IdTipoMov = 7 
		
		UPDATE EstadoCuenta
		SET CantOpHumano = CantOpHumano + 1
		WHERE IdCuentaAhorros=@IdCuenta

	

	SET @IdMov+=1
END
GO
/****** Object:  StoredProcedure [dbo].[MostrarEstadosCuenta]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MostrarNumCuentas]    Script Date: 10/26/2021 11:48:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MovimientosCuentaAhorros]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[MovimientosCuentaAhorros]
@OutCodeResult INT

AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY

		DECLARE @IdCuentaAhorro INT, 
		@IdMov INT,@IdMonMov INT, @IdMonedaCuenta INT, @IdTipoCuenta INT, 
		@Venta INT, @Compra Int, @cont INT =1, @Operacion INT, @Monto INT , 
		@nuevoSaldo INT,@IdTipoCambio INT, @IdTipoMov INT


WHILE @cont<=3563


--Encontrar id de la moneda de la cuenta 

	SET @IdMov = (@cont)

	SET @IdCuentaAhorro = (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)

	SET @IdTipoCuenta = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE Id=@IdCuentaAhorro)

	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TiposCuentaAhorros WHERE Id=@IdTipoCuenta)

-- Encontrar Moneda del Movimiento

	SET @IdMonMov = (SELECT IdMoneda FROM Movimientos WHERE Id =@IdMov )

-- Encontrar Tipo de Cambio

	SET @IdTipoCambio= (SELECT IdTipoCambio FROM Movimientos WHERE Id = @IdMov)

	SET @Venta = (SELECT TCVenta FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @Compra = (SELECT TCCompra FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @IdTipoMov= (SELECT IdTipoMov FROM Movimientos WHERE Id= @IdMov)

-- ENCONTRAR OPERACION


	SELECT @Operacion = (SELECT Operacion FROM TipoMov WHERE Id = @IdTipoMov)


-- Encontrar Monto

	SET @Monto = (SELECT Monto FROM Movimientos WHERE Id=@IdMov)




	IF @IdMonedaCuenta = @IdMonMov

					
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +@Monto
			WHERE Id=@IdMov;

		--referencia2
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - @Monto
			WHERE Id=@IdMov;
			
	IF (@IdMonedaCuenta = 1 AND @IdMonMov=2)
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo + (@Monto*@Compra)
			WHERE Id=@IdMov;
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - (@Monto*@Compra)
			WHERE Id=@IdMov;

	IF (@IdMonedaCuenta = 2 AND @IdMonMov=1)
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +( @Monto/@Venta)
			WHERE Id=@IdMov;
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo -  (@Monto/@Venta)
			WHERE Id=@IdMov;

	


	SET @nuevoSaldo =(SELECT NuevoSaldo FROM Movimientos WHERE Id=@IdMov)



	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE Id=@IdCuentaAhorro;

SET @cont= @cont+1;


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
/****** Object:  StoredProcedure [dbo].[UpdateMontoMonedaCuenta]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMontoMonedaCuenta]
AS
		DECLARE @IdCuentaAhorro INT, 
		@IdMov INT,@IdMonMov INT, @IdMonedaCuenta INT, @IdTipoCuenta INT, 
		@Venta INT, @Compra Int, @cont INT =1, @Operacion INT, @Monto INT , 
		@nuevoSaldo INT,@IdTipoCambio INT, @IdTipoMov INT, @Val INT, 
		@IdNumCuenta INT, @MontoMonedaCuenta INT;



WHILE @cont<3564
BEGIN


--Encontrar id de la moneda de la cuenta 

	SET @IdMov = (@cont)

	SET @IdCuentaAhorro =  (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)

	SET @IdTipoCuenta = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE Id=@IdCuentaAhorro)

	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TiposCuentaAhorros WHERE Id=@IdTipoCuenta)

-- Encontrar Moneda del Movimiento

	SET @IdMonMov = (SELECT IdMoneda FROM Movimientos WHERE Id =@IdMov )

-- Encontrar Tipo de Cambio

	SET @IdTipoCambio= (SELECT IdTipoCambio FROM Movimientos WHERE Id = @IdMov)

	SET @Venta = (SELECT TCVenta FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @Compra = (SELECT TCCompra FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @IdTipoMov= (SELECT IdTipoMov FROM Movimientos WHERE Id= @IdMov)

-- ENCONTRAR OPERACION


	SELECT @Operacion = (SELECT Operacion FROM TipoMov WHERE Id = @IdTipoMov)


-- Encontrar Monto

	SET @Monto = (SELECT Monto FROM Movimientos WHERE Id=@IdMov)

	IF (@IdMonedaCuenta= 1 AND @IdMonMov=1)			
		IF @Operacion = 1

			SET @MontoMonedaCuenta=@Monto 

			
			
		ELSE
			
			SET @MontoMonedaCuenta=-@Monto 
			
	ELSE IF (@IdMonedaCuenta = 1 AND @IdMonMov=2)
		
		IF @Operacion = 1
		
			SET @MontoMonedaCuenta = (@Compra * @Monto) 
			
		ELSE
			
			
			SET @MontoMonedaCuenta = (@Compra * -@Monto) 
			

	ELSE IF (@IdMonedaCuenta = 2 AND @IdMonMov=1)
		
		IF @Operacion = 1
			
			
			SET @MontoMonedaCuenta = (@Monto /@Venta) 
		
		
		ELSE
			
			SET @MontoMonedaCuenta = (@Monto / -@Venta)
			
	ELSE IF (@IdMonedaCuenta= 2 AND @IdMonMov	=2 )
		IF @Operacion = 1

			SET @MontoMonedaCuenta=@Monto 

			
		ELSE
			
			SET @MontoMonedaCuenta= -@Monto 
		

			
	
	--print(@MontoMonedaCuenta)


	UPDATE Movimientos
	SET MontoMonedaCuenta = @MontoMonedaCuenta
	WHERE Id=@IdMov;


	SET @cont= @cont+1;
	

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSaldoCuentaAhorros]    Script Date: 10/26/2021 11:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSaldoCuentaAhorros]
AS
DECLARE @i INT=1, @nuevoSaldo INT;

WHILE @i<25
BEGIN
	SET @nuevoSaldo = (SELECT SUM(MontoMonedaCuenta)
	FROM Movimientos
	WHERE IdCuenta=@i);

	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE Id=@i


	SET @i +=1

END;
GO
/****** Object:  StoredProcedure [dbo].[validarUsuario]    Script Date: 10/26/2021 11:48:55 PM ******/
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
