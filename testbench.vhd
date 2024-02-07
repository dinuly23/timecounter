library IEEE;
use IEEE.std_logic_1164.all;


entity timeCounter_tb is
end entity timeCounter_tb;

architecture sim of timeCounter_tb is
    -- Component declaration for the entity
    component timeCounter
        port (
            clk, reset: in STD_LOGIC;
	    timer_enable: in STD_LOGIC;
            timer_alarm_sec: in STD_LOGIC_VECTOR(5 downto 0);
            timer_alarm_min: in STD_LOGIC_VECTOR(5 downto 0);
            timer_alarm_hour: in STD_LOGIC_VECTOR(4 downto 0);
            sec: out STD_LOGIC_VECTOR(5 downto 0);
            min: out STD_LOGIC_VECTOR(5 downto 0);
            hour: out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    signal tb_clk: STD_LOGIC := '0';
    signal tb_reset: STD_LOGIC := '0';
    signal tb_timer_enable: STD_LOGIC := '0';
    signal tb_timer_alarm_sec: STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal tb_timer_alarm_min: STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal tb_timer_alarm_hour: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal tb_sec: STD_LOGIC_VECTOR(5 downto 0);
    signal tb_min: STD_LOGIC_VECTOR(5 downto 0);
    signal tb_hour: STD_LOGIC_VECTOR(4 downto 0);  
begin
    dut: timeCounter port map (
         clk => tb_clk,
         reset => tb_reset,
	 timer_enable => tb_timer_enable,
         timer_alarm_sec => tb_timer_alarm_sec,
         timer_alarm_min => tb_timer_alarm_min,
         timer_alarm_hour => tb_timer_alarm_hour,
         sec => tb_sec,
         min => tb_min,
         hour => tb_hour
    );
        
    -- Reset and clock
	tb_clk <= not tb_clk after 1 ns;
    	tb_reset <= '1', '0' after 5 ns;
        
    -- Generate the test stimulus
  	stimulus:
  	process begin

	    	-- Wait for the Reset to be released before
    		wait until (tb_reset  = '0');
		
		tb_timer_enable <= '1';
		tb_timer_alarm_sec <= "000000";
    		tb_timer_alarm_min <= "000100";
    		tb_timer_alarm_hour <= "00000";
    		wait for 10000 ns;

		tb_timer_enable <= '0';
		wait for 100 ns;

	   	-- Testing complete
   		 wait;
  	end process stimulus;
end architecture sim;
