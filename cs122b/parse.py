import sys

def parse_file(filename):
    ts_time_total = 0
    tj_time_total = 0
    ts_queries = 0
    tj_queries = 0
    file = open(filename, 'r')
    text = file.readlines()

    for x in text:
        split_list = x.split(',')
        ts_time_total += int(split_list[1])
        
        tj_time_total += int(split_list[2])
        ts_queries += 1
        tj_queries += 1
    
    ts_average = ts_time_total / ts_queries
    tj_average = tj_time_total / tj_queries

    print("ts average: " + str(ts_average))
    print("tj average: " + str(tj_average))
    

parse_file("MasterOneThread_Log.txt")
