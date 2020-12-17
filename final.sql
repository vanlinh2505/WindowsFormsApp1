USE [master]
GO
/****** Object:  Database [DBMS]    Script Date: 12/17/2020 9:21:48 PM ******/
CREATE DATABASE [DBMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBMS.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBMS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DBMS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBMS] SET  MULTI_USER 
GO
ALTER DATABASE [DBMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DBMS] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DBMS]
GO
/****** Object:  User [thilyvu]    Script Date: 12/17/2020 9:21:48 PM ******/
CREATE USER [thilyvu] FOR LOGIN [thilyvu] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dai]    Script Date: 12/17/2020 9:21:48 PM ******/
CREATE USER [dai] FOR LOGIN [dai] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [employee]    Script Date: 12/17/2020 9:21:48 PM ******/
CREATE ROLE [employee]
GO
ALTER ROLE [db_owner] ADD MEMBER [thilyvu]
GO
ALTER ROLE [employee] ADD MEMBER [dai]
GO
/****** Object:  UserDefinedFunction [dbo].[monan_daban]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[monan_daban](@mamonan int)
returns int
as
begin
	declare @soluong int
	select @soluong=sum(ct.Soluong) from Chitiethoadon as ct, hoadon as hd
	where  convert(date,hd.thoigian)=convert(date,getdate()) and ct.Mamonan=@mamonan and hd.trangthai=1
	if(@soluong is null)
	set @soluong=0
	return @soluong
end

GO
/****** Object:  Table [dbo].[Ban]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ban](
	[Maban] [int] IDENTITY(1,1) NOT NULL,
	[Tenban] [nvarchar](50) NOT NULL,
	[Trangthai] [nvarchar](50) NULL,
	[SoLuongKhach] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Maban] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ca]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ca](
	[Maca] [int] IDENTITY(1,1) NOT NULL,
	[Tenca] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Maca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiaCa]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiaCa](
	[Manv] [int] NOT NULL,
	[Maca] [int] NOT NULL,
	[ngay] [date] NOT NULL,
 CONSTRAINT [pk_chica] PRIMARY KEY CLUSTERED 
(
	[Manv] ASC,
	[Maca] ASC,
	[ngay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chitiethoadon]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chitiethoadon](
	[Mahoadon] [int] NOT NULL,
	[Mamonan] [int] NOT NULL,
	[Soluong] [int] NOT NULL,
 CONSTRAINT [pk_chitiethoadon] PRIMARY KEY CLUSTERED 
(
	[Mahoadon] ASC,
	[Mamonan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Congthuc]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Congthuc](
	[Mamonan] [int] NOT NULL,
	[Manl] [int] NOT NULL,
	[soluong] [float] NOT NULL,
 CONSTRAINT [pk_congthuc] PRIMARY KEY CLUSTERED 
(
	[Mamonan] ASC,
	[Manl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hoadon]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hoadon](
	[Mahoadon] [int] IDENTITY(1,1) NOT NULL,
	[Maban] [int] NULL,
	[Thoigian] [datetime] NOT NULL,
	[Tongbill] [float] NULL DEFAULT ((0)),
	[Manv] [int] NULL,
	[mavoucher] [int] NULL,
	[Trangthai] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Mahoadon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Monan]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Monan](
	[Mamonan] [int] IDENTITY(1,1) NOT NULL,
	[tenmonan] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Mamonan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Monantheongay]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Monantheongay](
	[ngay] [date] NOT NULL,
	[Mamonan] [int] NOT NULL,
	[gia] [float] NOT NULL,
	[tongsoluong] [int] NOT NULL,
 CONSTRAINT [pk_monantheongay] PRIMARY KEY CLUSTERED 
(
	[Mamonan] ASC,
	[ngay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguyenLieu]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguyenLieu](
	[Manl] [int] IDENTITY(1,1) NOT NULL,
	[tenNL] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Manl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Nguyenlieutheongay]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nguyenlieutheongay](
	[ngay] [date] NOT NULL,
	[Manl] [int] NOT NULL,
	[gia] [float] NULL,
	[tongsoluong] [int] NOT NULL,
 CONSTRAINT [pk_nguyenlieutheongay] PRIMARY KEY CLUSTERED 
(
	[ngay] ASC,
	[Manl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [int] IDENTITY(1,1) NOT NULL,
	[Hoten] [nvarchar](50) NOT NULL,
	[SoDT] [nvarchar](50) NOT NULL,
	[Ngaysinh] [date] NOT NULL,
	[luong] [float] NULL,
	[MaNQL] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Role] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[voucher]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher](
	[mavoucher] [int] IDENTITY(1,1) NOT NULL,
	[ten] [nvarchar](50) NOT NULL,
	[ngaybatdau] [date] NOT NULL,
	[ngayketthuc] [date] NOT NULL,
	[chitiet] [nvarchar](50) NULL,
	[Discount] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[mavoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[bandangsd]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[bandangsd]()
returns table
as
	return select maban from hoadon
	where Hoadon.Thoigian=convert(date,getdate()) and trangthai=0

GO
/****** Object:  UserDefinedFunction [dbo].[ct_monan]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[ct_monan](@mamonan int)
returns table
as
return
	(
			select nl.Manl 
			from Nguyenlieutheongay as nl,
			(select * from Congthuc where Mamonan=@mamonan)as ct
			where nl.Manl=ct.Manl and nl.ngay=CONVERT(date,getdate())
	)
	

GO
/****** Object:  UserDefinedFunction [dbo].[dsmonan]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[dsmonan]()
returns table
as
return
select ct.Mamonan,isnull(sum(ct.Soluong),0) as 'soluong_daban',convert(date,hd.Thoigian) as 'ngay' 
	from Chitiethoadon as ct,hoadon as hd 
	where hd.Mahoadon=ct.Mahoadon and convert(date,hd.Thoigian)=CONVERT(date,getdate()) 
	group by ct.Mamonan,convert(date,hd.Thoigian)

GO
SET IDENTITY_INSERT [dbo].[Ban] ON 

INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (31, N'Table 1', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (32, N'Table 2', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (33, N'Table 3', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (34, N'Table 4', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (35, N'Table 5', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (36, N'Table 6', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (37, N'Table 7', N'Available', 0)
INSERT [dbo].[Ban] ([Maban], [Tenban], [Trangthai], [SoLuongKhach]) VALUES (38, N'Table 8', N'Available', 0)
SET IDENTITY_INSERT [dbo].[Ban] OFF
INSERT [dbo].[Chitiethoadon] ([Mahoadon], [Mamonan], [Soluong]) VALUES (77, 1, 2)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (1, 1, 10)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (1, 2, 20)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (1, 3, 30)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (2, 3, 40)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (2, 4, 50)
INSERT [dbo].[Congthuc] ([Mamonan], [Manl], [soluong]) VALUES (2, 5, 50)
SET IDENTITY_INSERT [dbo].[Hoadon] ON 

INSERT [dbo].[Hoadon] ([Mahoadon], [Maban], [Thoigian], [Tongbill], [Manv], [mavoucher], [Trangthai]) VALUES (77, 31, CAST(N'2020-12-15 00:00:00.000' AS DateTime), 80000, NULL, 2, 1)
INSERT [dbo].[Hoadon] ([Mahoadon], [Maban], [Thoigian], [Tongbill], [Manv], [mavoucher], [Trangthai]) VALUES (78, 31, CAST(N'2020-12-16 00:00:00.000' AS DateTime), 0, NULL, 2, 1)
SET IDENTITY_INSERT [dbo].[Hoadon] OFF
SET IDENTITY_INSERT [dbo].[Monan] ON 

INSERT [dbo].[Monan] ([Mamonan], [tenmonan]) VALUES (4, N'Bo vien')
INSERT [dbo].[Monan] ([Mamonan], [tenmonan]) VALUES (2, N'bun bo')
INSERT [dbo].[Monan] ([Mamonan], [tenmonan]) VALUES (1, N'com chien')
INSERT [dbo].[Monan] ([Mamonan], [tenmonan]) VALUES (5, N'hay')
INSERT [dbo].[Monan] ([Mamonan], [tenmonan]) VALUES (3, N'Lau')
SET IDENTITY_INSERT [dbo].[Monan] OFF
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 1, 10000, 100)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 1, 40000, 1000)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-14' AS Date), 1, 20000, 10)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 1, 20000, 100)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 2, 20000, 200)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 2, 12222, 111)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 2, 10000, 100)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-09' AS Date), 3, 20000, 200)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-09' AS Date), 4, 30000, 100)
INSERT [dbo].[Monantheongay] ([ngay], [Mamonan], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-14' AS Date), 4, 10000, 90)
SET IDENTITY_INSERT [dbo].[NguyenLieu] ON 

INSERT [dbo].[NguyenLieu] ([Manl], [tenNL]) VALUES (4, N'bo')
INSERT [dbo].[NguyenLieu] ([Manl], [tenNL]) VALUES (5, N'bun')
INSERT [dbo].[NguyenLieu] ([Manl], [tenNL]) VALUES (1, N'com')
INSERT [dbo].[NguyenLieu] ([Manl], [tenNL]) VALUES (3, N'hang')
INSERT [dbo].[NguyenLieu] ([Manl], [tenNL]) VALUES (2, N'trung')
SET IDENTITY_INSERT [dbo].[NguyenLieu] OFF
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 1, NULL, 1000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 2, NULL, 2000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 3, NULL, 11000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 4, NULL, 10000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-08' AS Date), 5, NULL, 10000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 1, NULL, 10000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 2, NULL, 20000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 3, NULL, 34440)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 4, NULL, 5550)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-12' AS Date), 5, NULL, 5550)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-14' AS Date), 1, NULL, 100)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-14' AS Date), 2, NULL, 200)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-14' AS Date), 3, NULL, 300)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 1, NULL, 1000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 2, NULL, 2000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 3, NULL, 7000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 4, NULL, 5000)
INSERT [dbo].[Nguyenlieutheongay] ([ngay], [Manl], [gia], [tongsoluong]) VALUES (CAST(N'2020-12-15' AS Date), 5, NULL, 5000)
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([MaNV], [Hoten], [SoDT], [Ngaysinh], [luong], [MaNQL], [UserName], [Password], [Role]) VALUES (8, N'Thi Lý Vũ', N'0563010901', CAST(N'2000-01-09' AS Date), 20000, NULL, N'thilyvu', N'f3086a19f261ac92f72997538aeec807', N'manager')
INSERT [dbo].[NhanVien] ([MaNV], [Hoten], [SoDT], [Ngaysinh], [luong], [MaNQL], [UserName], [Password], [Role]) VALUES (12, N'Tran Quang Dai', N'0363738936', CAST(N'2020-12-07' AS Date), 2000, 8, N'dai', N'CFCD208495D565EF66E7DFF9F98764DA', N'employee')
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
SET IDENTITY_INSERT [dbo].[voucher] ON 

INSERT [dbo].[voucher] ([mavoucher], [ten], [ngaybatdau], [ngayketthuc], [chitiet], [Discount]) VALUES (2, N'giam 50 % ', CAST(N'2020-12-08' AS Date), CAST(N'2020-12-30' AS Date), N'1', 0.5)
INSERT [dbo].[voucher] ([mavoucher], [ten], [ngaybatdau], [ngayketthuc], [chitiet], [Discount]) VALUES (4, N'giam 50 % ', CAST(N'2020-12-08' AS Date), CAST(N'2020-12-30' AS Date), N'1', 0.5)
SET IDENTITY_INSERT [dbo].[voucher] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Monan__057758C6C44AEA05]    Script Date: 12/17/2020 9:21:48 PM ******/
ALTER TABLE [dbo].[Monan] ADD UNIQUE NONCLUSTERED 
(
	[tenmonan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__NguyenLi__FB74E83D6AB34D3A]    Script Date: 12/17/2020 9:21:48 PM ******/
ALTER TABLE [dbo].[NguyenLieu] ADD UNIQUE NONCLUSTERED 
(
	[tenNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiaCa]  WITH CHECK ADD FOREIGN KEY([Maca])
REFERENCES [dbo].[Ca] ([Maca])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiaCa]  WITH CHECK ADD FOREIGN KEY([Manv])
REFERENCES [dbo].[NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chitiethoadon]  WITH CHECK ADD FOREIGN KEY([Mahoadon])
REFERENCES [dbo].[Hoadon] ([Mahoadon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Congthuc]  WITH CHECK ADD FOREIGN KEY([Mamonan])
REFERENCES [dbo].[Monan] ([Mamonan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Congthuc]  WITH CHECK ADD FOREIGN KEY([Manl])
REFERENCES [dbo].[NguyenLieu] ([Manl])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Hoadon]  WITH CHECK ADD FOREIGN KEY([Maban])
REFERENCES [dbo].[Ban] ([Maban])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Hoadon]  WITH CHECK ADD FOREIGN KEY([Manv])
REFERENCES [dbo].[NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Hoadon]  WITH CHECK ADD FOREIGN KEY([mavoucher])
REFERENCES [dbo].[voucher] ([mavoucher])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Monantheongay]  WITH CHECK ADD FOREIGN KEY([Mamonan])
REFERENCES [dbo].[Monan] ([Mamonan])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Nguyenlieutheongay]  WITH CHECK ADD FOREIGN KEY([Manl])
REFERENCES [dbo].[NguyenLieu] ([Manl])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([MaNQL])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
/****** Object:  StoredProcedure [dbo].[themdonhang]    Script Date: 12/17/2020 9:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[themdonhang](@mahoadon int,@mamonan int,@soluong int)
as
begin
	if((select count(*) from Chitiethoadon where Mahoadon=@mahoadon and Mamonan=@mamonan)>0)
	begin
		update Chitiethoadon set Soluong=@soluong where Mahoadon=@mahoadon and Mamonan=@mamonan
	end
	else
	begin
		insert into Chitiethoadon values(@mahoadon,@mamonan,@soluong)
	end
end
GO
USE [master]
GO
ALTER DATABASE [DBMS] SET  READ_WRITE 
GO
