create database if not exists quit_file;

use quit_file;
CREATE TABLE courses (CID varchar(40), CTITLE varchar(30), CDUR int);
INSERT INTO courses (CID, CTITLE, CDUR)
VALUES 
('7890', 'DB2', 5),
('7910', 'Unix', 4),
('8500', 'Oracle', 5),
('8000', 'SQL server', 5),
('9000', 'SQL workshop', 3);

ALTER TABLE courses
ADD PRIMARY KEY (CID);

ALTER TABLE courses
CHANGE COLUMN CDUR COURSE_DURATION INT NOT NULL;

CREATE TABLE sessions (
  SNO int PRIMARY KEY,
  S_CID varchar(40) REFERENCES courses(CID),
  SDATE date,
  SINSTRUTOR varchar(20),
  SCANCEL varchar(5)
);

INSERT INTO sessions (SNO, S_CID, SDATE, SINSTRUTOR, SCANCEL)
VALUES 
(0, '7890', '2005-12-02', 'de keyser', ''),
(1, '7910', '2005-11-04', 'smiths', ''),
(2, '7890', '2006-01-08', 'de keyser', 'c'),
(3, '7890', '2006-02-22', 'de keyser', ''),
(4, '8000', '2006-04-05', 'tavernier', 'c'),
(5, '7910', '2006-01-08', 'ADAMSON', 'C'),
(6, '8500', '2006-04-05','ADAMSON', ''),
(7, '9000', '2006-06-07','ADAMSON', '');                                  

select * from courses;
select * from courses where CTITLE like '%sql%'; and cid not in('7800','7820'); # Q3. All Rows  like '%sql%' and Contains the Character Sequence SQL. 

select * from sessions;
select S_CID,MAX(SNO) from sessions group by S_CID order by 2;

