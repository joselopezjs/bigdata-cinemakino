USE [master]
GO
/****** Object:  Database [cinemakino]    Script Date: 10/23/2024 12:19:14 PM ******/
CREATE DATABASE [cinemakino]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cinemakino', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\cinemakino.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cinemakino_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\cinemakino_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [cinemakino] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cinemakino].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cinemakino] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cinemakino] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cinemakino] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cinemakino] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cinemakino] SET ARITHABORT OFF 
GO
ALTER DATABASE [cinemakino] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cinemakino] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cinemakino] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cinemakino] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cinemakino] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cinemakino] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cinemakino] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cinemakino] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cinemakino] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cinemakino] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cinemakino] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cinemakino] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cinemakino] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cinemakino] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cinemakino] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cinemakino] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cinemakino] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cinemakino] SET RECOVERY FULL 
GO
ALTER DATABASE [cinemakino] SET  MULTI_USER 
GO
ALTER DATABASE [cinemakino] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cinemakino] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cinemakino] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cinemakino] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [cinemakino] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [cinemakino] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'cinemakino', N'ON'
GO
ALTER DATABASE [cinemakino] SET QUERY_STORE = ON
GO
ALTER DATABASE [cinemakino] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [cinemakino]
GO
/****** Object:  Table [dbo].[gender_movie]    Script Date: 10/23/2024 12:19:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gender_movie](
	[id_gender_movie] [int] IDENTITY(1,1) NOT NULL,
	[name_gender_movie] [nvarchar](255) NULL,
 CONSTRAINT [PK_gender_movie] PRIMARY KEY CLUSTERED 
(
	[id_gender_movie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movie]    Script Date: 10/23/2024 12:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movie](
	[id_movie] [int] IDENTITY(1,1) NOT NULL,
	[id_gender_movie] [int] NULL,
	[title_movie] [nvarchar](255) NULL,
 CONSTRAINT [PK_movie] PRIMARY KEY CLUSTERED 
(
	[id_movie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movie_room]    Script Date: 10/23/2024 12:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movie_room](
	[id_movie_room] [int] IDENTITY(1,1) NOT NULL,
	[cinema_room] [int] NOT NULL,
	[seat] [int] NULL,
 CONSTRAINT [PK_movie_room] PRIMARY KEY CLUSTERED 
(
	[id_movie_room] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movie_screening]    Script Date: 10/23/2024 12:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movie_screening](
	[id_movie_screening] [int] IDENTITY(1,1) NOT NULL,
	[id_movie] [int] NULL,
	[date] [date] NULL,
	[time] [time](7) NULL,
	[price] [money] NULL,
 CONSTRAINT [PK_movie_screening] PRIMARY KEY CLUSTERED 
(
	[id_movie_screening] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 10/23/2024 12:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id_ticket] [int] IDENTITY(1,1) NOT NULL,
	[id_user] [int] NULL,
	[id_movie_screening] [int] NULL,
	[id_movie_room] [int] NULL,
 CONSTRAINT [PK_ticket] PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 10/23/2024 12:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[firs_name_user] [nvarchar](255) NULL,
	[last_name_user] [nvarchar](255) NULL,
	[email_user] [varchar](50) NULL,
	[phone_user] [varchar](35) NULL,
	[gender_user] [varchar](50) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[movie]  WITH CHECK ADD  CONSTRAINT [FK_movie_gender_movie] FOREIGN KEY([id_gender_movie])
REFERENCES [dbo].[gender_movie] ([id_gender_movie])
GO
ALTER TABLE [dbo].[movie] CHECK CONSTRAINT [FK_movie_gender_movie]
GO
ALTER TABLE [dbo].[movie_screening]  WITH CHECK ADD  CONSTRAINT [FK_movie_screening_movie] FOREIGN KEY([id_movie])
REFERENCES [dbo].[movie] ([id_movie])
GO
ALTER TABLE [dbo].[movie_screening] CHECK CONSTRAINT [FK_movie_screening_movie]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [FK_ticket_movie_room] FOREIGN KEY([id_movie_room])
REFERENCES [dbo].[movie_room] ([id_movie_room])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [FK_ticket_movie_room]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [FK_ticket_movie_screening] FOREIGN KEY([id_movie_screening])
REFERENCES [dbo].[movie_screening] ([id_movie_screening])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [FK_ticket_movie_screening]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [FK_ticket_user] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id_user])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [FK_ticket_user]
GO
USE [master]
GO
ALTER DATABASE [cinemakino] SET  READ_WRITE 
GO
