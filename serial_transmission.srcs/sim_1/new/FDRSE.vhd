library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FDRSE is
    Port (CLK, R, S, CE, D : in STD_LOGIC;
          Q : out STD_LOGIC);
end FDRSE;

architecture Behavioral of FDRSE is

begin
    process(CLK, R, S, CE, D)
    begin
        if rising_edge(CLK) then
            if R = '1' then
                Q <= '0';
            elsif S = '1' then
                Q <= '1';
            elsif CE = '1' then
                Q <= D;
            end if;
        end if;    
    end process;
end Behavioral;
