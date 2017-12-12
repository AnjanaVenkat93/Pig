authorinfo = load '/home/hduser/author-data.txt' using PigStorage(',') as (authorid:int, authorname:chararray);
bookinfo = load '/home/hduser/book-data.txt' using PigStorage(',') as (bookid:int, bookprice:int, authorid:int);
authorinfofiltered = FILTER authorinfo by INDEXOF(authorname,'J',0)==0;
bookinfofiltered = FILTER bookinfo by bookprice>=200;
bookauthorinfo = JOIN authorinfofiltered by authorid, bookinfofiltered by authorid;
store bookauthorinfo into '/home/hduser/bookinfopig';

