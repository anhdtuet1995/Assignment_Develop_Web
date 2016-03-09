/*
 * Dao Tuan Anh
 * MSSV: 13020003
 * Truong: UET-VNU
 * 10/3/2016
*/


/*-----------CAU 1------------*/
--tao database quanlysinhvien va 2 bang chucvu, sinhvien

create database if not exists quanlysinhvien CHARACTER SET utf8 COLLATE utf8_general_ci;

use quanlysinhvien;

create table if not exists chucvu(
	machucvu int not null auto_increment primary key,
	chucvu varchar(255) not null
);

create table if not exists sinhvien(
	id int not null auto_increment primary key,
	masv varchar(255) not null,
	hoten varchar(255) not null,
	machucvu int,
	diachi varchar(255),
	gioitinh text not null,
	diemtb float,
	constraint fk_ma foreign key (machucvu) references chucvu(machucvu) on delete cascade on update cascade
);
/*---------------------------------*/


/*---------CAU 2-------*/
-- 1. them 3 chuc vu

insert into chucvu(machucvu, chucvu) values (1, 'Lớp trưởng');
insert into chucvu(machucvu, chucvu) values (2, 'Bí thư');
insert into chucvu(machucvu, chucvu) values (3, 'Lớp phó');
-- 2. them 15 sinh vien

insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020001', 'Đào Tuấn Anh', 2, null, 'Nam', 8.5);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020002', 'Cao Anh Tuấn', null, null, 'Nam', 6.0);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020003', 'Đỗ Gia Đạt', 1, null, 'Nam', 9.0);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020004', 'Dư Tài Linh', null, null, 'Nam', 7.1);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020005', 'Dương Thi Huế', null, null, 'Nữ', 6.9);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020006', 'Đặng Thị Khôi', null, null, 'Nữ', 6.2);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020007', 'Nguyễn Ngọc Quang', null, null, 'Nam', 6.1);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020008', 'Nguyễn Sĩ Trung', null, null, 'Nam', 8.1);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020009', 'Trần Bá Quân', null, null, 'Nam', 7.5);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020010', 'Hoàng Đình Tấn', null, null, 'Nam', 4.0);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020011', 'Nguyễn Mạnh Cường', null, null, 'Nam', 8.3);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020012', 'Phạm Thị Hà', 3, null, 'Nữ', 7.3);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020012', 'Phạm Thị Hà', 2, null, 'Nữ', 7.3);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020013', 'Phan Thanh Hải', null, null, 'Nữ', 5.3);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020014', 'Trịnh Thị Hiền', null, null, 'Nữ', 7.7);
insert into sinhvien(masv, hoten, machucvu, diachi, gioitinh, diemtb) 
	values ('13020015', 'Nguyễn Hải Hoàng', null, null, 'Nam', 5.0);

--3. Liet ke danh sach sinh vien co diem trung binh tren 8 va sap xep giam dan
select * from sinhvien where diemtb > 8 order by diemtb DESC;

-- 4. Liet ke danh sach tat ca sinh vien gom ten sinh vien va chuc vu
select s.hoten, c.chucvu from 
	sinhvien s left join chucvu c on s.machucvu = c.machucvu;

-- 5. Liet ke danh sach sinh vien nam cac chuc vu trong lop
select s.hoten, c.chucvu from 
	sinhvien s inner join chucvu c on s.machucvu = c.machucvu;

-- 6. Danh sach sinh vien co diem trung binh cao nhat
select * from sinhvien order by diemtb DESC limit 5;

-- 7. Hien thi cac sinh vien co diem trung binh lon hon muc diem trung binh cua danh sach
select * from sinhvien where diemtb > (select avg(diemtb) from sinhvien);

-- 8. Liet ke cac sinh vien khong giu chuc vu nao
select s.*, c.chucvu from 
	sinhvien s left join chucvu c on s.machucvu = c.machucvu
	where s.machucvu is null;

-- 9. Cong them 1 diem cho sinh vien co diem trung binh thap nhat
update sinhvien
	set diemtb = diemtb+1
		where diemtb = (select * from (select min(diemtb) from sinhvien) as p);
/*-----------------------*/

/*---------CAU 3------------*/
-- Xoa sinh vien nam giu 2 chuc vu
delete from sinhvien
	where masv = (select * from (select masv from sinhvien group by hoten having count(machucvu) >= 2) as p);
/*--------------------------*/

