day01:
	# ===== DAY 01 =====
	docker-compose run spl shakespeare run solutions/day01_1.spl < input/day01.txt 2> /dev/null | tail -n1
	docker-compose run spl shakespeare run solutions/day01_2.spl < input/day01.txt 2> /dev/null | tail -n1

day02:
	# ===== DAY 02 =====
	cat input/day02.txt | tr " " "\n" | docker-compose run lolcode lolcode solutions/day02_1.lol | tail -n1
	cat input/day02.txt | tr " " "\n" | docker-compose run lolcode lolcode solutions/day02_2.lol | tail -n1

day03:
	# ===== DAY 03 =====
	xdg-open https://google.com >/dev/null 2>&1 || echo "Day 03 solution available at: https://docs.google.com/spreadsheets/d/1VV2_DT8vGQxzXnMW4ANaw7kSrRkH3nsDQpm2YpHVAQA/edit#gid=0"

day04:
	# ===== DAY 04 =====
	docker-compose run scala scalac solutions/day04_1.scala -d bin
	docker-compose run scala scala -classpath bin day04_1 < input/day04.txt

day05:
	# ===== DAY 05 =====
	docker-compose run haskell runhaskell solutions/day05.hs < input/day05.txt

day06:
	# ===== DAY 06 =====
	docker-compose run sql < solutions/day06.sql

day07:
	# ===== DAY 07 =====
	docker-compose run dart dart run solutions/day07.dart < input/day07.txt

day08:
	# ===== DAY 08 =====
	docker-compose run r Rscript solutions/day08.r < input/day08.txt

day09:
	# ===== DAY 09 =====
	docker-compose run mono csharp solutions/day09.cs < input/day09.txt

day10:
	# ===== DAY 10 =====
	docker-compose run pascal fpc -FEbin solutions/day10.pas
	docker-compose run pascal ./bin/day10 < input/day10.txt

day11:
	# ===== DAY 11 =====
	docker-compose run kotlin kotlinc solutions/day11.kt -d bin
	docker-compose run kotlin kotlin -classpath bin Day11Kt < input/day11.txt

all: day01 day02 day03 day04 day05 day06 day07 day08 day09 day10 day11
