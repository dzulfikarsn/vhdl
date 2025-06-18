library ieee;
use ieee.std_logic_1164.all;

entity Add5 is
    port(
        A, B    : in std_logic_vector(4 downto 0);
        Cin     : in std_logic;
        Sum     : out std_logic_vector(4 downto 0);
        Cout    : out std_logic
    );
end entity;

architecture Structural of Add5 is
    -- Declare internal carry signals between full adders
    signal C : std_logic_vector(5 downto 0);  -- C(0) = Cin, C(5) = Cout

    component FullAdder
        port(
            A, B, Cin   : in std_logic;
            Sum, Cout   : out std_logic
        );
    end component;

begin
    C(0) <= Cin;

    -- Instantiate Full Adders
    FA0: FullAdder port map (A(0), B(0), C(0), Sum(0), C(1));
    FA1: FullAdder port map (A(1), B(1), C(1), Sum(1), C(2));
    FA2: FullAdder port map (A(2), B(2), C(2), Sum(2), C(3));
    FA3: FullAdder port map (A(3), B(3), C(3), Sum(3), C(4));
    FA4: FullAdder port map (A(4), B(4), C(4), Sum(4), C(5));

    Cout <= C(5);

end Structural;