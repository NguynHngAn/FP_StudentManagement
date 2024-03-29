USE [QLSV]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStudentDateOfAdmission]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Tạo hàm Scalar
CREATE FUNCTION [dbo].[GetStudentDateOfAdmission] (@mssv INT)
RETURNS DATE
AS
BEGIN
DECLARE @date DATE
SELECT @date = Ngaynhaphoc FROM Student WHERE MSSV = @mssv
RETURN @date
END
GO
/****** Object:  Table [dbo].[Class]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[Malop] [nchar](8) NOT NULL,
	[SL_SV] [int] NOT NULL,
	[TenLop] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[Malop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[MaDK] [nchar](10) NOT NULL,
	[ngaydangky] [date] NOT NULL,
	[Ma_SV] [nchar](10) NOT NULL,
	[Ma_MonHoc] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[MaDK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Score]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Score](
	[MaDiem] [nchar](20) NOT NULL,
	[Ma_sinhvien] [nchar](10) NOT NULL,
	[Ma_MH] [nchar](10) NOT NULL,
	[DiemThi] [float] NOT NULL,
	[TrangThai] [nvarchar](10) NULL,
 CONSTRAINT [PK_Điểm thi] PRIMARY KEY CLUSTERED 
(
	[MaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[MSSV] [nchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[Phai] [nvarchar](5) NULL,
	[SDT] [nchar](10) NOT NULL,
	[CCCD] [nchar](12) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Ma_Lop] [nchar](8) NOT NULL,
	[Ngaynhaphoc] [date] NOT NULL,
 CONSTRAINT [PK_SinhVien] PRIMARY KEY CLUSTERED 
(
	[MSSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 16/04/2023 10:57:53 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[MMH] [nchar](10) NOT NULL,
	[TenMH] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Môn học] PRIMARY KEY CLUSTERED 
(
	[MMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Student] FOREIGN KEY([Ma_SV])
REFERENCES [dbo].[Student] ([MSSV])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Student]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Subject] FOREIGN KEY([Ma_MonHoc])
REFERENCES [dbo].[Subject] ([MMH])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Subject]
GO
ALTER TABLE [dbo].[Score]  WITH CHECK ADD  CONSTRAINT [FK_Score_Student] FOREIGN KEY([Ma_sinhvien])
REFERENCES [dbo].[Student] ([MSSV])
GO
ALTER TABLE [dbo].[Score] CHECK CONSTRAINT [FK_Score_Student]
GO
ALTER TABLE [dbo].[Score]  WITH CHECK ADD  CONSTRAINT [FK_Score_Subject] FOREIGN KEY([Ma_MH])
REFERENCES [dbo].[Subject] ([MMH])
GO
ALTER TABLE [dbo].[Score] CHECK CONSTRAINT [FK_Score_Subject]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Class] FOREIGN KEY([Ma_Lop])
REFERENCES [dbo].[Class] ([Malop])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Class]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [RG_ngaydangky_CHK] CHECK  ((datediff(year,[dbo].[GetStudentDateOfAdmission]([Ma_SV]),[ngaydangky])>=(0)))
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [RG_ngaydangky_CHK]
GO
ALTER TABLE [dbo].[Score]  WITH CHECK ADD  CONSTRAINT [ST_DiemThi_CHK] CHECK  (([DiemThi]>=(0) AND [DiemThi]<=(10)))
GO
ALTER TABLE [dbo].[Score] CHECK CONSTRAINT [ST_DiemThi_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_CCCD_CHK] CHECK  ((len([CCCD])=(12)))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_CCCD_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_Email_CHK] CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_Email_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_MSSV_CHK] CHECK  ((len([MSSV])=(10)))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_MSSV_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_Ngaynhaphoc_CHK] CHECK  ((datediff(year,[NgaySinh],[Ngaynhaphoc])>=(18)))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_Ngaynhaphoc_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_Phai_CHK] CHECK  (([Phai]='Nam' OR [Phai]=N'Nữ' OR [Phai]='Nu'))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_Phai_CHK]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [ST_SDT_CHK] CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [ST_SDT_CHK]
GO
