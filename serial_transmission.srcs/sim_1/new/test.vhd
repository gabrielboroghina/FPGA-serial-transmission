library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test is
--  Port ( );
end test;

architecture Behavioral of test is
    component top is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               clk, reset, start : in STD_LOGIC;
               serial_out, ready : out STD_LOGIC;
               st : out STD_LOGIC_vector(3 downto 0) );
    end component;

    signal D : STD_LOGIC_VECTOR (7 downto 0) := "10110111";
    signal clk, reset, start, serial_out, ready : STD_LOGIC := '0';
    signal st_o : STD_LOGIC_vector(3 downto 0);
begin
    uut: top PORT MAP(D => D, clk => clk, reset => reset, start => start, serial_out => serial_out, ready => ready, st =>st_o);
    
    clk <= not clk after 2ns;

    process
    begin
        wait for 3 ns;
        reset <= '1';
        start <= '1';
        wait for 5ns;
        reset <= '0';
        D <= "10110111";
        wait for 100ns;
    end process;
end Behavioral;
