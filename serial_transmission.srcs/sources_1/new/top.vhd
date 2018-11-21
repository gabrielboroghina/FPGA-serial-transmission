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
           serial_out, ready : out STD_LOGIC;
           st : out STD_LOGIC_vector(3 downto 0) );
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
               TXready, rdy, load, depl, Ddisp : out STD_LOGIC;
               st : out STD_LOGIC_vector(3 downto 0));
    end component;
    
    signal parity, depl, load, fdrse_s, fdrse_r, not_reset, load_s, depl_s, s1_in : STD_LOGIC;
    signal sli_in, sli_in_2, D_fdrse_2, clr_num12, ready_s, num12_in, TXready_out : STD_LOGIC;
    signal Q_num12 : STD_LOGIC_VECTOR (3 downto 0);
    signal st_aux : STD_LOGIC_vector(3 downto 0);
begin
    parity_gen: parity_generator PORT MAP(D => D, parity => parity);
    
    fdrse_s <= load and parity;
    fdrse_r <= load and (not parity);
    fdrse_block: FDRSE PORT MAP(CLK => clk, R => fdrse_r, S => fdrse_s, CE => depl, D => '1', Q => sli_in);
    
    not_reset <= not reset;
    s1_in <= depl_S or load_s;
    X74_194_1: X74_194 PORT MAP (CLK => clk, CLR => not_reset, S0 => load_s, S1 => s1_in, SRI => '0', SLI => sli_in, 
                                 D => D(7), C => D(6), B => D(5), A => D(4),
                                 QD => open, Qc => open, QA => sli_in_2);
                                 
    X74_194_2: X74_194 PORT MAP (CLK => clk, CLR => not_reset, S0 => load_s, S1 => s1_in, SRI => '0', SLI => sli_in_2, 
                                 D => D(3), C => D(2), B => D(1), A => D(0),
                                 QD => open, Qc => open, QA => D_fdrse_2);
                                 
    fdrse_out: FDRSE PORT MAP (CLK => clk, R => load_s, CE => depl_s, S => reset, D => D_fdrse_2, Q => serial_out);
    
    clr_num12 <= reset or ready_s;
    num12: CB4CLE PORT MAP (CLK => clk, CLR => clr_num12, L => '0', CE => depl_s, D => (others => '0'), 
                            Q => Q_num12, CEO => open, TC => open);
               
    num12_in <= (not Q_num12(0)) and (not Q_num12(1)) and Q_num12(2) and Q_num12(3);
    fsm: H2_fsm PORT MAP (start => start, RXready => '1', reset => reset, num12 => num12_in, Dreq => '1', clk => clk,
                          TXready => TXready_out, rdy => open, load => load_s, depl => depl_s, Ddisp => open, st=>st_aux);
                          
    op_ready : FDCE PORT MAP (CLK => clk, CLR => reset, CE => TXready_out, D => '1', Q => ready_s);
    ready <= ready_s;
    st <= st_aux;
end Behavioral;
