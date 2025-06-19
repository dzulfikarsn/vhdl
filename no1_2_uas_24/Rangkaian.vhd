library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Rangkaian is
    port(
        CLOCK   : in std_logic;
        RESET   : in std_logic;
        LOAD    : in std_logic;
        DATA    : in std_logic_vector(3 downto 0);
        Q       : out std_logic_vector(3 downto 0)
    );
end entity Rangkaian;

architecture Behavioral of Rangkaian is
    signal temp : std_logic_vector(3 downto 0);
begin
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            temp <= "0000";
        elsif rising_edge(CLOCK) then
            if LOAD = '1' then
                temp <= DATA;
            else
                temp <= std_logic_vector(unsigned(temp) + 1);
            end if;
        end if;
    end process;

    Q <= temp xor std_logic_vector(shift_left(unsigned(temp), 1));
end architecture Behavioral;