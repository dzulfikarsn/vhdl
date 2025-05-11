library ieee;
use ieee.std_logic_1164.all;

entity tb_MultiDropBus is
end tb_MultiDropBus;

architecture sim of tb_MultiDropBus is
    signal Clock, Reset : std_logic := '0';
    signal A_EN, B_EN, C_EN : std_logic := '0';
    signal A_SEL, B_SEL, C_SEL : std_logic := '0';
    signal Data_bus : std_logic_vector(7 downto 0);
    signal A, B, C : std_logic_vector(7 downto 0);

    component MultiDropBus
        port (
            Clock, Reset : in std_logic;
            A_EN, B_EN, C_EN : in std_logic;
            A_SEL, B_SEL, C_SEL : in std_logic;
            Data_bus : inout std_logic_vector(7 downto 0);
            A, B, C : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    DUT: MultiDropBus
        port map (
            Clock => Clock,
            Reset => Reset,
            A_EN => A_EN, B_EN => B_EN, C_EN => C_EN,
            A_SEL => A_SEL, B_SEL => B_SEL, C_SEL => C_SEL,
            Data_bus => Data_bus,
            A => A, B => B, C => C
        );

    -- Clock process
    Clock_process : process
    begin
        while true loop
            Clock <= '0';
            wait for 5 ns;
            Clock <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    Stim_proc: process
    begin
        -- Reset all
        Reset <= '0';
        wait for 10 ns;
        Reset <= '1';
        wait for 10 ns;

        -- Init: set A = x"55"
        A_SEL <= '0'; B_SEL <= '0'; C_SEL <= '0';
        Data_bus <= x"55";
        A_EN <= '1';
        wait for 10 ns;
        A_EN <= '0';
        Data_bus <= (others => 'Z'); -- Release the bus

        -- A -> C
        A_SEL <= '1'; wait for 1 ns; -- A drives bus
        C_EN <= '1'; wait for 10 ns; -- C loads from bus
        A_SEL <= '0'; C_EN <= '0';

        -- C -> B
        C_SEL <= '1'; wait for 1 ns;
        B_EN <= '1'; wait for 10 ns;
        C_SEL <= '0'; B_EN <= '0';

        -- B -> C
        B_SEL <= '1'; wait for 1 ns;
        C_EN <= '1'; wait for 10 ns;
        B_SEL <= '0'; C_EN <= '0';

        -- B -> A
        B_SEL <= '1'; wait for 1 ns;
        A_EN <= '1'; wait for 10 ns;
        B_SEL <= '0'; A_EN <= '0';

        wait for 20 ns;
        assert false report "Test completed" severity failure;
    end process;

end sim;