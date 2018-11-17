library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity H2_fsm is
    Port ( start, RXready, reset, num12, Dreq, clk : in STD_LOGIC;
           TXready, rdy, load, depl, Ddisp : out STD_LOGIC);
end H2_fsm;

architecture Behavioral of H2_fsm is
    type state_type is (S0, S1, S2, S3, S4, S5); -- states of the FSM
    signal state : state_type := S0; -- current state
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            state <= S0; -- reset state
        elsif rising_edge(clk) then
            case state is
                when S0 =>
                    rdy <= '1';
                    if start = '1' then
                        state <= S1;
                    end if;
                    
                when S1 =>
                    load <= '1';
                    state <= S2;
                    
                when S2 =>
                    Ddisp <= '1';
                    if Dreq = '1' then
                        state <= S3;
                    end if;
                    
                when S3 =>
                    depl <= '1';
                    state <= S4;
                    
                when S4 =>
                    if num12 = '1' then
                        state <= S5;
                    else
                        state <= S3;
                    end if;
                    
                when S5 =>
                    TXready <= '1';
                    depl <= '0';
                    if RXready = '1' then
                        state <= S0;
                    else
                        state <= S5;
                    end if;
                when others => NULL;
            end case;
        end if;
    end process;
end Behavioral;
