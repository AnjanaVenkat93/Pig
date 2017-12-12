medicaldata = load '/home/hduser/medical.txt' as (name, dept, amt);
medicaldatagroup = GROUP medicaldata by name;
medicalclaim = FOREACH medicaldatagroup GENERATE group as user, AVG(medicaldata.amt) as claimavg;
store medicalclaim into '/home/hduser/medicalclaimpig';
