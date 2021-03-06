firstyrdata = load '/home/hduser/2000dat.txt' using PigStorage(',') AS (catid:chararray, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
--dump firstyrdata;
data2000 = foreach firstyrdata GENERATE $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2000;
--dump data2000;
secondyrdata = load '/home/hduser/2001dat.txt' using PigStorage(',') AS (catid:chararray, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
data2001 = foreach secondyrdata GENERATE $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2001;
thirdyrdata = load '/home/hduser/2002dat.txt' using PigStorage(',') AS (catid:chararray, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
data2002 = foreach thirdyrdata GENERATE $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2002;
retailjoined = join data2000 by $0, data2001 by $0, data2002 by $0;
--dump retailjoined;
retailmergecol = foreach retailjoined GENERATE $0,$1,$2,$5,$8;
--describe retailmergecol;
--dump retailmergecol;
growthpercent = foreach retailmergecol GENERATE $0,$1,(($3-$2)/$2*100) as growth1, (($4-$3)/$3*100) as growth2;
--dump growthpercent;
avggrowthvalue = foreach growthpercent GENERATE $0,$1,($2+$3)/2 as avggrowth;
--dump avggrowthvalue;
growthgreaterthan10 = FILTER avggrowthvalue by avggrowth>10;
--dump growthgreaterthan10;
growthlessthan5 = FILTER avggrowthvalue by avggrowth<-5;
dump growthlessthan5;
