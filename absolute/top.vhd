library ieee;
use ieee.std_logic_1164.all;

entity Top is
    port(
        A, B    : in std_logic_vector(3 downto 0);
        X       : out std_logic_vector(4 downto 0)
    ); 
end entity;

architecture Structural of Top is

    -- Component declaration for the 5-bit adder
    component Add5
        port(
            A, B    : in std_logic_vector(4 downto 0);
            Cin     : in std_logic;
            Sum     : out std_logic_vector(4 downto 0);
            Cout    : out std_logic
        );
    end component;

    -- Signals
    signal A_ext, B_ext, B_inverted : std_logic_vector(4 downto 0);
    signal R        : std_logic_vector(4 downto 0);     -- Result of A - B
    signal R_inv    : std_logic_vector(4 downto 0);     -- R XOR r4
    signal r4       : std_logic;                        -- Sign bit of R
    signal dummy    : std_logic;                        -- Unused carry out

begin
    -- Sign-extend A and B to 5 bits, MSB equal to sign bit
    A_ext <= A(3) & A;
    B_ext <= B(3) & B;

    -- Invert B to compute A - B = A + (~B + 1)
    B_inverted <= not B_ext;

    -- First 5-bit adder: R = A - B = A + (~B + 1)
    SubstractState: Add5 port map(
        A       => A_ext,
        B       => B_inverted,
        Cin     => '1',
        Sum     => R,
        Cout    => dummy
    );

    -- Extract the sign bit of R
    r4 <= R(4);

    -- Generate logic: XOR each bit of R with its sign bit (r4)
    gen_xor: for i in 0 to 4 generate
        R_inv(i) <= R(i) xor r4;
    end generate;
    
    -- Second 5-bit adder: X = |R| = (R XOR r4) + r4
    AbsoluteStage: Add5 port map(
        A       => R_inv,
        B       => "00000",
        Cin     => r4,
        Sum     => X,
        Cout    => dummy
    );

end Structural;