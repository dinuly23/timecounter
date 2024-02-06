library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity timeCounter is
    port(
        clk, reset: in STD_LOGIC;
	timer_enable: in STD_LOGIC;
        timer_alarm_sec: in STD_LOGIC_VECTOR(5 downto 0);
        timer_alarm_min: in STD_LOGIC_VECTOR(5 downto 0);
        timer_alarm_hour: in STD_LOGIC_VECTOR(4 downto 0);
        sec: out STD_LOGIC_VECTOR(5 downto 0);
        min: out STD_LOGIC_VECTOR(5 downto 0);
        hour: out STD_LOGIC_VECTOR(4 downto 0)
    );
end entity timeCounter;
    
architecture synth of timeCounter is
    type statetype is (S0, S1, S2, S3);
    signal state: statetype;
    signal temp_sec, temp_min: unsigned(5 downto 0);
    signal temp_hour: unsigned(4 downto 0);
begin
    process(clk, reset) begin
        if reset = '1' then
            state <= S0;
            temp_sec <= (others => '0');
            temp_min <= (others => '0');
            temp_hour <= (others => '0');
        elsif rising_edge(clk) then
            if (timer_enable = '1' and timer_alarm_sec = std_logic_vector(temp_sec) and timer_alarm_min = std_logic_vector(temp_min) and timer_alarm_hour = std_logic_vector(temp_hour)) then
                temp_sec <= (others => '0');
                temp_min <= (others => '0');
                temp_hour <= (others => '0');
            else
                case state is
                    when S0 =>
                        if temp_sec = "111010" then 
                            if temp_min = "111011" then
                                if temp_hour = "10111" then
                                    state <= S3;
                                else 
                                    state <= S2;
                                end if;
                            else 
                                state <= S1;
                            end if;
                        else 
                            state <= S0;
                        end if;
                        temp_sec <= temp_sec + 1;
                    when S1 =>
                        state <= S0;
                        temp_sec <= (others => '0');
                        temp_min <= temp_min + 1;
                    when S2 =>
                        state <= S0;
                        temp_sec <= (others => '0');
                        temp_min <= (others => '0');
                        temp_hour <= temp_hour + 1;
                    when S3 =>
                        state <= S0;
                        temp_sec <= (others => '0');
                        temp_min <= (others => '0');
                        temp_hour <= (others => '0');
                    when others => 
                        state <= S0;
                end case;
                sec <= std_logic_vector(temp_sec);
                min <= std_logic_vector(temp_min);
                hour <= std_logic_vector(temp_hour);
            end if; 
        end if;
    end process;
end architecture synth;
