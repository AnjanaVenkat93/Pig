wordfile = load '/home/hduser/wordcount.txt' using TextLoader() as (word:chararray);
words = FOREACH wordfile GENERATE FLATTEN(TOKENIZE(word));
groupofwords = GROUP words by $0;
countofwords = FOREACH groupofwords GENERATE group,COUNT(words);
store countofwords into '/home/hduser/pigwordcount/wordcountpig.txt' using PigStorage();
