day01:
	# ===== DAY 01 =====
	docker-compose run spl shakespeare run solutions/day01_1.spl < input/day01.txt 2> /dev/null | tail -n1
	docker-compose run spl shakespeare run solutions/day01_2.spl < input/day01.txt 2> /dev/null | tail -n1

day02:
	# ===== DAY 02 =====
	cat input/day02.txt | tr " " "\n" | docker-compose run lolcode lolcode solutions/day02_1.lol | tail -n1
	cat input/day02.txt | tr " " "\n" | docker-compose run lolcode lolcode solutions/day02_2.lol | tail -n1

all: day01 day02
