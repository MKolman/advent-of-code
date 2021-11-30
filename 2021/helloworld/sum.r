nums <- strsplit(readLines(con = file("stdin"))[1], " ")[[1]]
print(strtoi(nums[1])+strtoi(nums[2]))
