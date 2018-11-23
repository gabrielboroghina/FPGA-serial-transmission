library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test is
--  Port ( );
end test;

architecture Behavioral of test is
    component top is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               clk, reset, start, dreq, rxready : in STD_LOGIC;
               serial_out, ready : out STD_LOGIC;
               st : out STD_LOGIC_vector(3 downto 0) );
    end component;

    signal D : STD_LOGIC_VECTOR (7 downto 0) := "10110111";
    signal clk, start, serial_out, ready, dreq, rxready : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal st_o : STD_LOGIC_vector(3 downto 0);
begin
    uut: top PORT MAP(D => D, clk => clk, reset => reset, start => start, serial_out => serial_out, ready => ready, st => st_o, dreq => dreq, rxready => rxready);
    
    clk <= not clk after 2ns;

    process
    begin
        rxready <= '0';
        wait for 5 ns;
        reset <= '0';
        D <= "01011001";
        wait for 5ns;
        start <= '1';
        wait for 5ns;
        start <= '0';
        wait for 10ns;
        dreq <= '1';
        wait for 5ns;
        dreq <= '0';
        wait for 100ns;
        rxready <= '1';
    end process;
end Behavioral;
