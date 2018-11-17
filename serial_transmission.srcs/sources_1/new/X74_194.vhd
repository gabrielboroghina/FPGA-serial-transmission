library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity X74_194 is
    Port ( CLK, CLR : in STD_LOGIC;
           S0, S1, SLI, SRI : in STD_LOGIC;
           A, B, C, D : in STD_LOGIC;
           QA, QB, QC, QD : out STD_LOGIC );
end X74_194;

architecture Behavioral of X74_194 is
    signal LA, LB, LC, LD : STD_LOGIC;
begin
    process(CLK, CLR, S0, S1, SLI, SRI, A, B, C, D)
    begin
        if CLR = '0' then
            LA <= '0'; LB <= '0'; LC <= '0'; LD <= '0';
        elsif rising_edge(CLK) then
            if S0 = '1' and S1 = '1'  then
                LA <= A; LB <= B; LC <= C; LD <= D;
            elsif S0 = '1' and S1 = '0' then
                LD <= LC; LC <= LB; LB <= LA; LA <= SRI;
            elsif S0 = '0' and S1 = '1' then
                LA <= LB; LB <= LC; LC <= LD; LD <= SLI;
            end if;
        end if;
    end process;
    
    QA <= LA;
    QB <= LB;
    QC <= LC;
    QD <= LD;
end Behavioral;
