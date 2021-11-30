python:
	python3 sum.py < input.txt
cpp:
	g++ sum.cpp -o bin/sumcpp
	./bin/sumcpp < input.txt
c:
	gcc sum.c -o bin/sumc
	./bin/sumc < input.txt
go:
	go run sum.go < input.txt
bash:
	bash sum.sh < input.txt
perl:
	perl sum.pl < input.txt
php:
	php sum.php < input.txt
rust:
	rustc sum.rs -o bin/sumrs
	./bin/sumrs < input.txt	
js:
	docker-compose run node node helloworld/sum.js < input.txt
ruby:
	docker-compose run ruby ruby helloworld/sum.rb < input.txt
java:
	docker-compose run java javac helloworld/sum.java -d helloworld/bin
	docker-compose run java java -classpath helloworld/bin sum < input.txt
swift:
	docker-compose run swift swift helloworld/sum.swift < input.txt
julia:
	docker-compose run julia julia helloworld/sum.jl < input.txt
kotlin:
	docker-compose run kotlin kotlinc helloworld/sum.kt -d helloworld/bin
	docker-compose run kotlin kotlin -classpath helloworld/bin SumKt < input.txt
mono:
	docker-compose run mono csharp helloworld/sum.cs < input.txt
pascal:
	docker-compose run pascal fpc -FEhelloworld/bin helloworld/sum.pas
	docker-compose run pascal ./helloworld/bin/sum < input.txt
r:
	docker-compose run r Rscript helloworld/sum.r < input.txt
spl:
	docker-compose run spl shakespeare run helloworld/sum.spl < input.txt
lolcode:
	cat input.txt | tr " " "\n" | docker-compose run lolcode lolcode helloworld/sum.lol
sql:
	docker-compose run sql < sum.sql
haskell:
	docker-compose run haskell runhaskell helloworld/sum.hs < input.txt
dart:
	docker-compose run dart dart run helloworld/sum.dart < input.txt
scala:
	docker-compose run scala scalac helloworld/sum.scala -d helloworld/bin
	docker-compose run scala scala -classpath helloworld/bin sum < input.txt
