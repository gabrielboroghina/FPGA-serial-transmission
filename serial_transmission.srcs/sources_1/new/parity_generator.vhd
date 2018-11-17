library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity parity_generator is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           parity : out STD_LOGIC);
end parity_generator;

architecture Behavioral of parity_generator is

begin
    parity <= D(0) xor D(1) xor D(2) xor D(3) xor D(4) xor D(5) xor D(6) xor D(7);
end Behavioral;
