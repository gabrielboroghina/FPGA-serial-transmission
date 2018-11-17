library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FDCE is
    Port ( CLK, CLR, CE, D : in STD_LOGIC;
           Q : out STD_LOGIC );
end FDCE;

architecture Behavioral of FDCE is

begin
    process(CLK, CLR, CE, D)
    begin
        if CLR = '1' then
            Q <= '0';
        elsif CE = '1' and rising_edge(CLK) then
            Q <= D;
        end if;
    end process;
end Behavioral;
