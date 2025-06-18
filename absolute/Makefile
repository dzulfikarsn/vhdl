EXEC = tb_Top

all: build run

# compile all the files
build:
	ghdl analyze fa.vhd
	ghdl analyze add5.vhd
	ghdl analyze top.vhd
	ghdl analyze tb_top.vhd
	ghdl elaborate $(EXEC)

run:
	ghdl -r $(EXEC) --vcd=wave.vcd
	gtkwave wave.vcd &

clean:
	rm --force *.cf *.vcd