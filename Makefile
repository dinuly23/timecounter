GHDL=ghdl
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) testbench.vhd timecounter.vhd 
	@$(GHDL) -e $(FLAGS) timeCounter_tb 
	@$(GHDL) -r $(FLAGS) timeCounter_tb --wave=wave.ghw --stop-time=20us
	