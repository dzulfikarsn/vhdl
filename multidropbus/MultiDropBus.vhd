library ieee;
use ieee.std_logic_1164.all;

entity MultiDropBus is
    port (
        Clock, Reset : in std_logic;
        A_EN, B_EN, C_EN : in std_logic; -- Enable untuk menulis ke register
        A_SEL, B_SEL, C_SEL : in std_logic; -- Untuk memilih siapa yang mengisi data bus
        Data_bus : inout std_logic_vector(7 downto 0);
        A, B, C : out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of MultiDropBus is
    signal reg_A, reg_B, reg_C : std_logic_vector(7 downto 0);
begin

    -- Bus assignment (tri-state logic)
    Data_bus <= reg_A when A_SEL = '1' else
                reg_B when B_SEL = '1' else
                reg_C when C_SEL = '1' else
                (others => 'Z');

    -- Register A
    process (Clock, Reset)
    begin
        if (Reset = '0') then
            reg_A <= (others => '0');
        elsif rising_edge(Clock) then
            if A_EN = '1' then
                reg_A <= Data_bus;
            end if;
        end if;
    end process;

    -- Register B
    process (Clock, Reset)
    begin
        if (Reset = '0') then
            reg_B <= (others => '0');
        elsif rising_edge(Clock) then
            if B_EN = '1' then
                reg_B <= Data_bus;
            end if;
        end if;
    end process;

    -- Register C
    process (Clock, Reset)
    begin
        if (Reset = '0') then
            reg_C <= (others => '0');
        elsif rising_edge(Clock) then
            if C_EN = '1' then
                reg_C <= Data_bus;
            end if;
        end if;
    end process;

    -- Output assignment
    A <= reg_A;
    B <= reg_B;
    C <= reg_C;

end architecture;