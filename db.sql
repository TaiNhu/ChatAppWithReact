USE [master]
GO
/****** Object:  Database [chatappcsharp]    Script Date: 4/10/2023 5:26:19 PM ******/
CREATE DATABASE [chatappcsharp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'chatappcsharp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\chatappcsharp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'chatappcsharp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\chatappcsharp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [chatappcsharp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [chatappcsharp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [chatappcsharp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [chatappcsharp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [chatappcsharp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [chatappcsharp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [chatappcsharp] SET ARITHABORT OFF 
GO
ALTER DATABASE [chatappcsharp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [chatappcsharp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [chatappcsharp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [chatappcsharp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [chatappcsharp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [chatappcsharp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [chatappcsharp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [chatappcsharp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [chatappcsharp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [chatappcsharp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [chatappcsharp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [chatappcsharp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [chatappcsharp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [chatappcsharp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [chatappcsharp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [chatappcsharp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [chatappcsharp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [chatappcsharp] SET RECOVERY FULL 
GO
ALTER DATABASE [chatappcsharp] SET  MULTI_USER 
GO
ALTER DATABASE [chatappcsharp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [chatappcsharp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [chatappcsharp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [chatappcsharp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [chatappcsharp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [chatappcsharp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'chatappcsharp', N'ON'
GO
ALTER DATABASE [chatappcsharp] SET QUERY_STORE = OFF
GO
USE [chatappcsharp]
GO
/****** Object:  Table [dbo].[members]    Script Date: 4/10/2023 5:26:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[members](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [varchar](10) NULL,
	[roomId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 4/10/2023 5:26:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messages](
	[id] [varchar](50) NOT NULL,
	[content] [nvarchar](255) NULL,
	[typeId] [int] NULL,
	[roomId] [varchar](50) NULL,
	[owner] [varchar](10) NULL,
	[no] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messageTypes]    Script Date: 4/10/2023 5:26:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messageTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rooms]    Script Date: 4/10/2023 5:26:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rooms](
	[id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 4/10/2023 5:26:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[members] ON 

INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (13, N'admin', N'a17718be-f8b9-4d92-809d-08f2a749abe4')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (14, N'tai', N'a17718be-f8b9-4d92-809d-08f2a749abe4')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (25, N'nguoi la', N'f0677f43-6b02-42a3-a5bc-0f3ffd440791')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (26, N'admin', N'f0677f43-6b02-42a3-a5bc-0f3ffd440791')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (27, N'oho', N'ec2643be-278e-40e3-883d-510fec6e8ecf')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (28, N'tai', N'ec2643be-278e-40e3-883d-510fec6e8ecf')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (29, N'ehe e', N'c8619e8e-e7dc-4e88-9b0f-a43cede3b60b')
INSERT [dbo].[members] ([id], [memberId], [roomId]) VALUES (30, N'oho', N'c8619e8e-e7dc-4e88-9b0f-a43cede3b60b')
SET IDENTITY_INSERT [dbo].[members] OFF
GO
SET IDENTITY_INSERT [dbo].[messages] ON 

INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'007aca11-0986-4ff9-9b38-37b3bfa83453', N'thoi ke :(', 1, N'c8619e8e-e7dc-4e88-9b0f-a43cede3b60b', N'oho', 74)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'0a1cbb25-c589-4205-9090-b6db76707e7b', N'ok thanks', 1, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'admin', 68)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'0e518398-37e9-45a9-b281-461bcab94ee2', N'do you have some thing new for me :|', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 55)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'10c7ff42-f6ef-43ca-bd15-07f323e54ce7', N'oh oh give it for me', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 58)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'1da715c4-471c-4fbf-8bf4-c442757fd1aa', N'hehe :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 36)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'22faead1-144b-49ef-8a5a-0babd3e66893', N'hbkkhkjhkjh', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 8)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'2d00203d-a0a7-4f11-bdd9-157b6c6be1c9', N'sao ban', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 9)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'2efd61e6-d71d-4dab-97a5-4b5c6dac2a96', N'he he ', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 13)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'34047911-af2c-4de9-8836-aae70714defb', N':( yes, i do', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 56)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'357f5ad7-cb49-4f82-8372-8b8eeab10d67', N'9ec75550-ef4b-49ad-9dc7-17c0637c727cmeo.jpg', 2, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'nguoi la', 67)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'35fbd81d-c99d-499b-b284-a6647ec00443', N'yo yo!!!!!!!!!!!! :(', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 69)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'376d62da-2283-4a42-a871-52357e3670c3', N'b3f40f67-0e0e-402f-aa9c-d8ab91cffa2aNguyen-Nhu-Tai-TopCV.vn-050323.231357.pdf', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 59)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'3bcbbdaf-aa0a-47d3-bb69-14bc67ddc224', N'42fb1bac-6319-4a57-bd19-4b7063305de3yandere.gif', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 70)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'4a8cc53d-72b3-438f-a58c-deb357067317', N'o kia ', 1, N'ec2643be-278e-40e3-883d-510fec6e8ecf', N'tai', 71)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'4d4b93b3-aa17-4a9d-9c4e-b145e3612375', N'con con :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 45)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'4dbcf5fb-29c7-4bcc-903a-4232935b60d7', N'd9e2903f-01b7-44b5-a53c-7aa1ed943678dmmakima.jpg', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 47)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'55212a34-3eb9-44b6-8f3f-d70e051a3078', N'77cfde24-5b75-4851-8e24-2c8fcbb54587Wallpaper 4K Pc Gif Gallery.gif', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 48)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'5cde1757-23c2-4532-8f7c-40a27413e683', N'gui cai anh paht', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 46)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'5dffdd75-956f-47b9-9406-cf95776a3618', N'kaka', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 16)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'60593404-e9ea-4602-bf21-f698615fed71', N'a khong co gi ban oi', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 10)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'6a9c46ef-c4f2-47b6-ab8a-cecfbb16c9b3', N'aaaaaaaaaaaaa', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 11)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'6d980cd1-6df7-4704-899c-12d6295dde05', N'ok', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 22)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'6db6a320-519d-4bec-9891-03230806fb5c', N'cung cha hieu tai sao', 1, N'c8619e8e-e7dc-4e88-9b0f-a43cede3b60b', N'ehe e', 73)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'7ab5896d-7075-4cb5-bbb2-f0f1c51e8b57', N'Sao bạn kì vậy', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 14)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'7aed673c-ef13-4a5d-9dcb-4093c486ba33', N'vl chưa tiền đâu mà cho giờ :(', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 29)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'7b564902-bfd5-48e3-a30c-ac75252044d8', N':) đang tính mượn tiền dạo này nghèo quá :(', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 28)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'7e740d7b-1f9f-418e-b961-93c28f57bf4d', N'i hope for it', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 63)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'8877eff5-8f21-4f35-9fe0-e7cf1d5b5370', N'alo con do ko', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 44)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'8cb74f32-7ede-4288-aa23-609d0706de05', N'067a47b2-1b18-4528-8ee5-6d6fe5688b92cutecute.gif', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 64)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'91fced16-ebc2-4203-a8f4-a098172cd71b', N':(:|', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 51)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'9614dbdb-a6e3-4aa6-ab2d-f85005a6eca4', N'what', 1, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'admin', 66)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'966a11f8-53ac-42ff-869a-fb19baa016fa', N'loli :( girl:)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 57)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'96ffcdd5-4f46-4947-a014-b3611aa897e0', N'chao tai', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 12)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'99a14f37-218f-4328-8df9-d977330f251d', N'cai gi', 1, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'admin', 20)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'9b38d7a5-b4a3-4c46-a32d-219427631a2b', N'a ha', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 17)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'9e08629c-3940-48c9-b09a-63a97e1b2463', N'long time no see :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 54)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'a0702465-fa99-42b6-bc38-ab326351fa7d', N'Nói gì mà úp mở thế :|', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 27)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ae3ee4ea-49f3-4fca-9c45-8cbd366bf1b1', N'nice', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 61)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'af839790-cfa0-424d-9e7f-ec6e753c6d62', N'985aba05-a69b-4282-88a0-f4223a63b013Đoàn Thị Thanh Trà - 21DH123396.pptx', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 49)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'b6e90695-de0d-40e4-a9b0-0be3ffd909e6', N'eo :( nghèo thế bạn :|', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 30)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ba95609b-44c5-4323-9280-a621d38c65f7', N'alo', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 52)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'bd7fe398-7479-4896-8688-512400f322a2', N'sao là sao bạn', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 32)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'bdddc0ab-6fb4-46aa-a5e2-cc053a55d624', N'what the heck', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 60)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'c7f6df2c-6b63-43b3-9602-48f30b6cecaa', N'hyhy', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 24)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'c93b9b76-9450-4f04-9160-72dbc3aed75b', N':((', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 33)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ca39f476-3fdb-441b-b6e6-3e62cf6c1ae8', N'7cec8dae-a51d-4447-bbe9-322718582501cutecute.gif', 2, N'ec2643be-278e-40e3-883d-510fec6e8ecf', N'oho', 72)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'd50e07d5-3e9f-463f-ab5d-280ddd0b8d94', N'alo nay sao rồi bạn :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 31)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'd629fdae-f7f3-48de-be5a-49a244776f7c', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 19)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'e6748522-bca6-4dcc-94e1-5b9e31fc3282', N':))', 1, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'nguoi la', 65)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'e6eac949-1c96-43f2-9d34-7bbcc45e3534', N':) cái gì cơ:|', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 35)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ebc2f032-d154-4113-bdc9-d813154867f8', N'Ê nói nghe nè bạn :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 26)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ef9e3203-e4ee-4dda-a656-07a5645655e8', N'958ee8ad-5eee-41e3-b219-86428acaf832tohru-tohru-disapointed.gif', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 43)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'f098a336-a9f1-4c1b-8332-c3239a863c01', N'ba4e65ae-2ef6-4555-b45f-2140f748822c958ee8ad-5eee-41e3-b219-86428acaf832tohru-tohru-disapointed.gif', 2, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 53)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'f2765a6c-88b6-45e1-89b2-e89de15b9433', N'i have some thing for you aswell', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 62)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'f40c8ff4-6bbd-4dfc-be33-f8a82f58422c', N':| à có cái này hay lắm nè :)', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'admin', 34)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'f8e4ae4f-7f0d-4e74-8cb1-cee5af01c061', N'nice picture', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 50)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'fa52476e-5ca8-46df-9369-2117979ba69d', N'khong co gi ban oi', 1, N'f0677f43-6b02-42a3-a5bc-0f3ffd440791', N'nguoi la', 21)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'fa7cadb7-2fee-403a-afef-d02b2d46b3d5', N'ừm ừm', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 15)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'fd2d274c-c5d0-4d71-9967-ee58a57773ea', N'hmmm', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 23)
INSERT [dbo].[messages] ([id], [content], [typeId], [roomId], [owner], [no]) VALUES (N'ffe3bcb7-03bc-42e1-b0d9-8ebf36d0cd71', N':(:):|(', 1, N'a17718be-f8b9-4d92-809d-08f2a749abe4', N'tai', 25)
SET IDENTITY_INSERT [dbo].[messages] OFF
GO
SET IDENTITY_INSERT [dbo].[messageTypes] ON 

INSERT [dbo].[messageTypes] ([id], [type]) VALUES (1, N'text')
INSERT [dbo].[messageTypes] ([id], [type]) VALUES (2, N'file')
SET IDENTITY_INSERT [dbo].[messageTypes] OFF
GO
INSERT [dbo].[rooms] ([id]) VALUES (N'a17718be-f8b9-4d92-809d-08f2a749abe4')
INSERT [dbo].[rooms] ([id]) VALUES (N'c8619e8e-e7dc-4e88-9b0f-a43cede3b60b')
INSERT [dbo].[rooms] ([id]) VALUES (N'ec2643be-278e-40e3-883d-510fec6e8ecf')
INSERT [dbo].[rooms] ([id]) VALUES (N'f0677f43-6b02-42a3-a5bc-0f3ffd440791')
GO
INSERT [dbo].[users] ([id]) VALUES (N'admin')
INSERT [dbo].[users] ([id]) VALUES (N'ehe e')
INSERT [dbo].[users] ([id]) VALUES (N'nguoi la')
INSERT [dbo].[users] ([id]) VALUES (N'oho')
INSERT [dbo].[users] ([id]) VALUES (N'tai')
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD FOREIGN KEY([memberId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD FOREIGN KEY([roomId])
REFERENCES [dbo].[rooms] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([owner])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([roomId])
REFERENCES [dbo].[rooms] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([typeId])
REFERENCES [dbo].[messageTypes] ([id])
GO
USE [master]
GO
ALTER DATABASE [chatappcsharp] SET  READ_WRITE 
GO
