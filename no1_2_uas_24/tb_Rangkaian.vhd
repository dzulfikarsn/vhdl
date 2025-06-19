library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Rangkaian is
end entity tb_Rangkaian;

architecture Behavioral of tb_Rangkaian is
    -- Deklarasi sinyal internal
    signal CLOCK    : std_logic := '0';
    signal RESET    : std_logic := '0';
    signal LOAD     : std_logic := '0';
    signal DATA     : std_logic_vector(3 downto 0) := (others => '0');
    signal Q        : std_logic_vector(3 downto 0);

    -- Deklarasi component
    component Rangkaian
        port(
            CLOCK   : in std_logic;
            RESET   : in std_logic;
            LOAD    : in std_logic;
            DATA    : in std_logic_vector(3 downto 0);
            Q       : out std_logic_vector(3 downto 0)
        );
    end component Rangkaian;

begin
    -- Instansiasi component
    UUT: Rangkaian
        port map(
            CLOCK   => CLOCK,
            RESET   => RESET,
            LOAD    => LOAD,
            DATA    => DATA,
            Q       => Q
        );

    -- Stimulus proses
    stim_proc: process
    begin
        -- Reset awal
        CLOCK <= '0'; RESET <= '1'; LOAD <= '0'; wait for 10 ns;
        CLOCK <= '1'; RESET <= '1'; LOAD <= '0'; wait for 10 ns;

        -- Lepas reset
        CLOCK <= '0'; RESET <= '0'; wait for 10 ns;
        CLOCK <= '1'; wait for 10 ns;

        -- Increment beberapa kali
        for i in 1 to 5 loop
            CLOCK <= '0'; wait for 10 ns;
            CLOCK <= '1'; wait for 10 ns;
        end loop;

        -- LOAD nilai x"C" (1100)
        CLOCK <= '0'; LOAD <= '1'; DATA <= x"C"; wait for 10 ns;
        CLOCK <= '1'; wait for 10 ns;

        -- Lepas LOAD dan lanjut increment
        CLOCK <= '0'; LOAD <= '0'; wait for 10 ns;
        CLOCK <= '1'; wait for 10 ns;

        for i in 1 to 5 loop
            CLOCK <= '0'; wait for 10 ns;
            CLOCK <= '1'; wait for 10 ns;
        end loop;

        wait;
    end process;

end architecture Behavioral;