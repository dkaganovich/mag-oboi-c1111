data = load '$input' using PigStorage('\t') as (bigram:chararray, year:int, occurrences:int, books:int);
data_grp = group data by bigram;
data_aver = foreach data_grp {
	total_occurrences = SUM(data.occurrences);
	total_books = SUM(data.books);
	generate group as bigram, (float)total_occurrences / total_books as aver_occurrences;
};
data_aver_sorted = order data_aver by aver_occurrences desc, bigram asc;
result = limit data_aver_sorted 10;
store result into '$output' using PigStorage('\t');
