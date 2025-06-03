EXEC = tb_Majority
SRC = $(wildcard *.vhd)

all: build run

# compile all the files
build:
	ghdl analyze $(SRC)
	ghdl elaborate $(EXEC)

run:
	ghdl -r $(EXEC) --vcd=wave.vcd

clean:
	rm --force *.cf *.vcd