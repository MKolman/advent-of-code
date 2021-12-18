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
	docker-compose run scala scalac solutions/day04.scala -d bin
	docker-compose run scala scala -classpath bin day04 < input/day04.txt

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

day12:
	# ===== DAY 12 =====
	docker-compose run swift swift solutions/day12.swift < input/day12.txt

day13:
	# ===== DAY 13 =====
	bash solutions/day13.sh < input/day13.txt

day14:
	# ===== DAY 14 =====
	docker-compose run julia julia solutions/day14.jl < input/day14.txt

day15:
	# ===== DAY 15 =====
	docker-compose run lua lua solutions/day15.lua < input/day15.txt

day16:
	# ===== DAY 16 =====
	gcc solutions/day16.c -o bin/day16
	./bin/day16 < input/day16.txt

day17:
	# ===== DAY 17 =====
	perl solutions/day17.pl < input/day17.txt

day18:
	# ===== DAY 18 =====
	rustc solutions/day18.rs -o bin/day18
	./bin/day18 < input/day18.txt	
	
all: day01 day02 day03 day04 day05 day06 day07 day08 day09 day10 day11 day12 day13 day14 day15 day16 day17 day18
