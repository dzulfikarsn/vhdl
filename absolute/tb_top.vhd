library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Top is
end entity;

architecture Test of tb_Top is

    -- Component under test
    component Top
        port(
            A, B : in  std_logic_vector(3 downto 0);
            X    : out std_logic_vector(4 downto 0)
        );
    end component;

    -- Test signals
    signal A, B : std_logic_vector(3 downto 0);
    signal X    : std_logic_vector(4 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Top port map (
        A => A,
        B => B,
        X => X
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: A = 0x7, B = 0xE → X = 01001
        A <= "0111"; B <= "1110"; wait for 10 ns;

        -- Test Case 2: A = 0x3, B = 0x7 → X = 00100
        A <= "0011"; B <= "0111"; wait for 10 ns;

        -- Test Case 3: A = 0xB, B = 0xD → X = 00010
        A <= "1011"; B <= "1101"; wait for 10 ns;

        -- Test Case 4: A = 0x6, B = 0xC → X = 01010
        A <= "0110"; B <= "1100"; wait for 10 ns;

        -- End simulation
        wait;
    end process;

end architecture;
