create table userInfo_tbl (
user_id 		varchar(20) primary key,
user_pw 		varchar(20) not null,
user_name 		varchar(20) not null,
user_email 		varchar(20),
user_address 	varchar(50) not null,
user_phone 		varchar(20) not null
);

create table board_tbl (
board_num 			int auto_increment primary key,
board_title 		varchar(500) not null,
board_writer 		varchar(20) not null,
board_content 		varchar(500) not null,
board_location 		varchar(50) not null,
board_date 			datetime default current_timestamp,
board_storeId		bigint,
board_time			int not null
);

create table storeInfo_tbl (
store_id 				bigint primary key,
store_pw 				varchar(30) not null,
store_name 				varchar(30) not null,
store_pname 			varchar(30) not null,
store_phone 			varchar(30) not null,
store_category			varchar(20)	not null,
store_address			varchar(255) not null,
store_operationHour		varchar(255) not null,
store_closedDay			varchar(255) not null,
store_deliveryFee 		int	not null
);

CREATE TABLE menu_tbl (
menu_id				int auto_increment PRIMARY KEY,
menu_storeId		bigint,
menu_name			varchar(255) NOT NULL unique key,
menu_price			int	NOT NULL,
menu_pictureUrl		text NULL
); 

CREATE TABLE order_tbl (
order_id			int auto_increment PRIMARY KEY,
order_menuName		text(20) NOT NULL,
order_userId		varchar(20)	NOT NULL,
order_boardNum 		int,
order_price			int	NOT NULL
);

create table comment_tbl (
comment_num       int auto_increment primary key,
comment_boardNum	int,
comment_name     varchar(20) NOT NULL,
comment_content   varchar(500),
comment_price    int NOT NULL,
comment_userId	varchar(20)
);

CREATE TABLE Mypage_tbl (
mypage_num      int auto_increment PRIMARY KEY,
mypage_date    datetime default current_timestamp,
mypage_userId    varchar(20) NOT NULL,
mypage_nickname  varchar(20) NOT NULL,
mypage_menuName    varchar(20) NOT NULL,
mypage_price     int NOT NULL
);

select * from userinfo_tbl;
select * from board_tbl;
select * from storeInfo_tbl;
select * from menu_tbl;
select * from order_tbl;
select * from comment_tbl;

desc storeInfo_tbl;
desc userInfo_tbl;

alter table order_tbl add foreign key (order_userId) references userinfo_tbl(user_id) on delete cascade;
alter table menu_tbl add foreign key (menu_storeId) references storeinfo_tbl(store_id) on delete cascade;
alter table board_tbl add foreign key (board_storeId) references storeinfo_tbl(store_id) on delete cascade;
alter table board_tbl add foreign key (board_writer) references userinfo_tbl(user_id) on delete cascade;
alter table comment_tbl add foreign key (comment_boardNum) references board_tbl(board_num) on delete cascade;
alter table mypage_tbl add foreign key (mypage_userId) references userinfo_tbl(user_id) on delete cascade;


alter table storeinfo_tbl add `store_miniPrice` int(20) not null after `store_deliveryFee`; 

-- 이 밑으로는 테스트 구문 (위의 테이블은 생성 후, 컬럼 추가하기) --------------------------------------------------------------------------------------------------------------------------------------

SELECT TIME_FORMAT(SEC_TO_TIME(board_time * 60), '%i 분 %s 초') AS BOARD_TIME FROM board_tbl;

SELECT SEC_TO_TIME(board_time * 60) AS BOARD_TIME FROM board_tbl;

ALTER TABLE board_tbl ADD board_time int(15) after board_storeId;

alter table comment_tbl add unique key (comment_userId);

drop index comment_userId on comment_tbl;

SET foreign_key_checks = 0;

drop table storeinfo_tbl;

SET foreign_key_checks = 1;

ALTER TABLE board_tbl ADD board_store varchar(100) after board_date;

ALTER TABLE comment_tbl ADD comment_userId varchar(100) after comment_price;

ALTER TABLE menu_tbl ADD menu_store varchar(100) after menu_pictureUrl;

ALTER TABLE storeInfo_tbl ADD store_query varchar(100) after store_deliveryFee;

ALTER TABLE order_tbl ADD order_boardNum int after order_storeName;

ALTER TABLE menu_tbl DROP menu_store;

select * from userinfo_tbl;
select * from board_tbl;
select * from storeInfo_tbl;
select * from menu_tbl;
select * from order_tbl;
select * from comment_tbl;

select (sum(order_price)) as totalprice from order_tbl where (order_boardNum = 26 && order_userid = 'hhj1210');

SELECT SUM(order_price) AS totalPrice FROM order_tbl WHERE (order_boardNum = 26 && order_userid = 'hhj1210');

select sum(price) + (sum(fee)/count(fee)) from order_tbl where order_boardNum = ?, order_userid = ?

SELECT order_menuName, order_price FROM order_tbl WHERE (order_boardNum = 43 && order_userId = 'hhj1210');

SELECT store_deliveryFee FROM storeInfo_tbl WHERE store_id = 123123;

SELECT menu_storeId, menu_pictureUrl, menu_name, menu_price FROM menu_tbl, storeInfo_tbl WHERE storeInfo_tbl.store_id = menu_tbl.menu_storeId;

alter table order_tbl add foreign key (order_userId) references userInfo_tbl (user_id);

alter table menu_tbl add foreign key (menu_storeId) references storeInfo_tbl (store_id);

alter table comment_tbl add foreign key (comment_num) references board_tbl (board_num);

SELECT menu_pictureUrl, menu_name, menu_price FROM menu_tbl, storeInfo_tbl WHERE storeInfo_tbl.store_Id = menu_tbl.menu_storeId;

SELECT store_name, store_phone, store_deliveryFee FROM storeInfo_tbl WHERE store_category = '치킨';

select * from  userInfo_tbl;
desc userInfo_tbl;

select * from board_tbl;
desc board_tbl;

select * from storeInfo_tbl;
desc storeInfo_tbl;

select * from menu_tbl;
desc menu_tbl;

select * from order_tbl;
desc order_tbl;

select * from comment_tbl;
select * from board_tbl;
select * from storeInfo_tbl;
desc comment_tbl;
desc board_tbl;

INSERT INTO comment_tbl (comment_name, comment_content, comment_price, comment_boardNum) VALUES ('asd', '123', 123, (SELECT board_num FROM board_tbl));

SELECT comment_name, comment_content, comment_price FROM comment_tbl, board_tbl WHERE comment_tbl.comment_boardNum = board_tbl.board_num;

SELECT comment_name, comment_content, comment_price FROM comment_tbl WHERE comment_tbl.comment_boardNum = 4;

SELECT board_num, board_title, board_write, board_location, DATE_FORMAT(BOARD_DATE, "%y-%m-%d") AS BOARD_DATE FROM board_tbl, storeinfo_tbl WHERE board_category = storeinfo_tbl.store_id(?);

ALTER TABLE board_tbl ADD board_store varchar(100) after board_date;

ALTER TABLE comment_tbl ADD comment_userId varchar(100) after comment_price;

INSERT INTO menu_tbl (menu_pictureUrl, menu_name, menu_price) values (1, 1, 1);

SELECT menu_pictureUrl, menu_name, menu_price FROM menu_tbl;

UPDATE menu_tbl SET menu_pictureUrl = 0, menu_name = 324, menu_price = 555 WHERE menu_name = 123;

UPDATE menu_tbl SET menu_pictureUrl = 1, menu_name = 555, menu_price = 111 WHERE menu_name = 324;

SELECT COUNT(*) AS COUNT FROM board_tbl WHERE board_store = '?hosik';
SELECT COUNT(*) AS COUNT FROM board_tbl WHERE board_store = '?bbq';

INSERT INTO comment_tbl (comment_name, comment_content, comment_price, comment_boardNum) VALUES ('hhj1210', 0, 13, 28);

DELETE FROM comment_tbl WHERE comment_name = 'SDASSA' and comment_userId = 'hhj1210';

alter table comment_tbl add  foreign key (comment_userId) references userinfo_tbl(user_id) on delete cascade;
alter table order_tbl add  foreign key (order_userId) references userinfo_tbl(user_id) on delete cascade;
alter table menu_tbl add  foreign key (menu_storeId) references storeinfo_tbl(store_id) on delete cascade;
alter table board_tbl add  foreign key (board_storeId) references storeinfo_tbl(store_id) on delete cascade;
