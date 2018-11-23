library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_x74_194 is
--  Port ( );
end test_x74_194;

architecture Behavioral of test_x74_194 is
    component X74_194 is
    Port ( CLK, CLR : in STD_LOGIC;
           S0, S1, SLI, SRI : in STD_LOGIC;
           A, B, C, D : in STD_LOGIC;
           QA, QB, QC, QD : out STD_LOGIC );
    end component;
    
    signal clr, s0, s1, sli, sri, a, b, c, d, qa_s, qb_s, qc_s, qd_s : std_logic := '0';
    signal clk : std_logic := '0';
begin
    clk <= not clk after 2ns;
    uut: X74_194 PORT MAP (clk => clk, clr => clr, s0 => s0, s1 => s1, sli => sli, sri=> sri, a => a, b => b, c => c, d => d,
                            qa => qa_s, qb => qb_s, qc => qc_s, qd => qd_s);
    
    process
    begin
       clr <= '0';
       sli <= '1';
       wait for 5ns;
       clr <= '1';
       a <= '1';
       c <= '1';
       s0 <= '1';
       s1 <= '1';
       wait for 5ns;
       s0 <= '0';
       wait for 20ns;
    end process;

end Behavioral;
