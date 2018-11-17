library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity CB4CLE is
    Port ( CLK, CLR : in STD_LOGIC;
           L, CE : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(3 downto 0);
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           CEO, TC : out STD_LOGIC);
end CB4CLE;

architecture Behavioral of CB4CLE is
    signal R : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(CLK, CLR, D, L, CE)
    begin
        if CLR = '1' then
            R <= "0000";
            CEO <= '0';
            TC <= '0';
        elsif L = '0' and CE = '0' then
            CEO <= '0';
        elsif rising_edge(CLK) then
            if L = '1' then
                R <= D;
            elsif L = '0' and CE = '1' then
                R <= STD_LOGIC_VECTOR(unsigned(R) + 1);
            end if;
        end if;
    end process;
    Q <= R;
end Behavioral;
