library ieee;
use ieee.std_logic_1164.all;

entity Majority is
    port(
        a, b, c, d : in std_logic;
        f : out std_logic
    );
end entity;

architecture Behavioral of Majority is
begin
    f <= (not a and not b and not c) or
         (not a and not b and not d) or
         (not a and not c and not d) or
         (not b and not c and not d) or
          
         (b and c and d) or
         (a and c and d) or
         (a and b and d) or
         (a and b and c);
end architecture;