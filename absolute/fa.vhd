library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
    port(
        A, B, Cin   : in std_logic;
        Sum, Cout   : out std_logic
    );
end entity;

architecture Structural of FullAdder is
    signal axb, ab, axb_cin : std_logic;
begin
    axb <= A xor B;
    Sum <= axb xor Cin;
    ab <= A and B;
    axb_cin <= axb and Cin;
    Cout <= ab or axb_cin;
end Structural;