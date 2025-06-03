library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Majority is
end tb_Majority;

architecture Behavioral of tb_Majority is
    component Majority is
        port(
            a, b, c, d : in std_logic;
            f : out std_logic
        );
    end component;

    signal a, b, c, d : std_logic := '0';
    signal f : std_logic;
begin
    uut: Majority
        port map(
            a => a,
            b => b,
            c => c,
            d => d,
            f => f
        );
    
    stim_proc: process
        variable vec : std_logic_vector(3 downto 0);
    begin
        for i in 0 to 15 loop
            vec := std_logic_vector(to_unsigned(i, 4));
            a <= vec(3);
            b <= vec(2);
            c <= vec(1);
            d <= vec(0);
            wait for 10 ns;
        end loop;
        
        wait;
    end process;
end architecture;

