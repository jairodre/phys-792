random.exe: random.cc 
	g++ -std=c++11 -I /home/liu_lab/shared/include/ -L /home/liu_lab/shared/lib/ -lCore -lMathCore random.cc -o random.exe


