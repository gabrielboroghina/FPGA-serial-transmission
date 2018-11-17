----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2018 10:00:06 AM
-- Design Name: 
-- Module Name: test_CB4CLE - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_CB4CLE is
--  Port ( );
end test_CB4CLE;

architecture Behavioral of test_CB4CLE is
    component CB4CLE is
        Port ( CLK, CLR : in STD_LOGIC;
               L, CE : in STD_LOGIC;
               D : in STD_LOGIC_VECTOR(3 downto 0);
               Q : out STD_LOGIC_VECTOR(3 downto 0);
               CEO, TC : out STD_LOGIC);
    end component;
    
    signal CLK_s, CLR_s, L_s, CE_s, CEO_s, TC_s : std_logic := '0';
    signal D_s, Q_s : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: CB4CLE port map(CLK => CLK_s, CLR => CLR_s, L => L_s, CE => CE_s, D => D_s, Q => Q_s, CEO => CEO_s, TC => TC_s);

    CLK_s <= not CLK_s after 2ns;
    CLR_s <= '0';
    process
    begin
        wait for 10ns;
        D_s <= "0000";
        L_s <= '1';
        CE_s <= '1';
        wait for 5ns;
        L_s <= '0';
        wait for 100ns;
    end process;
end Behavioral;
