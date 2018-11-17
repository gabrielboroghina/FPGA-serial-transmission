----------------------------------------------------------------------------------
-- Students: Gabriel Boroghina & Mihaela Catrina 
-- 
-- Create Date: 11/17/2018 04:09:30 PM
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           clk, reset, start : in STD_LOGIC;
           serial_out, ready : out STD_LOGIC );
end top;

architecture Behavioral of top is
    component parity_generator is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               parity : out STD_LOGIC);
    end component;
    
    component X74_194 is
        Port ( CLK, CLR : in STD_LOGIC;
               S0, S1, SLI, SRI : in STD_LOGIC;
               A, B, C, D : in STD_LOGIC;
               QA, QB, QC, QD : out STD_LOGIC );
    end component;
    
    component CB4CLE is
        Port ( CLK, CLR : in STD_LOGIC;
               L, CE : in STD_LOGIC;
               D : in STD_LOGIC_VECTOR(3 downto 0);
               Q : out STD_LOGIC_VECTOR(3 downto 0);
               CEO, TC : out STD_LOGIC);
    end component;
    
    component FDCE is
        Port ( CLK, CLR, CE, D : in STD_LOGIC;
               Q : out STD_LOGIC );
    end component;
    
    component FDRSE is
        Port (CLK, R, S, CE, D : in STD_LOGIC;
              Q : out STD_LOGIC);
    end component;
    
    component H2_fsm is
        Port ( start, RXready, reset, num12, Dreq, clk : in STD_LOGIC;
               TXready, rdy, load, depl, Ddisp : out STD_LOGIC);
    end component;
    
    signal parity, depl, load, fdrse_s, fdrse_r : STD_LOGIC;
begin
    parity_gen: parity_generator PORT MAP(D => D, parity => parity);
    
    fdrse_s <= load and parity;
    fdrse_r <= load and (not parity);
    fdrse_block: FDRSE PORT MAP(CLK => clk, R => fdrse_r, S => fdrse_s, CE => depl, D => '1');
end Behavioral;
