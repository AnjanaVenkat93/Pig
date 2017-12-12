weblog = load '/home/hduser/weblog.txt' as (user:chararray, bank:chararray, time:chararray);
gateway = load '/home/hduser/gateway.txt' as (bank:chararray,reliabilitypercent:float);
webgateway = join weblog by bank, gateway by bank;
usergateway = GROUP webgateway by user;
reliabilityavg = FOREACH usergateway GENERATE group, AVG(webgateway.reliabilitypercent) as successrate;
result = FILTER reliabilityavg by successrate > 90.0F;
store result into '/home/hduser/reliabilityresultpig';
