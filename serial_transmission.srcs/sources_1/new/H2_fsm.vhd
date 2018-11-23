library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity H2_fsm is
    Port ( start, RXready, reset, num12, Dreq, clk : in STD_LOGIC;
           TXready, rdy, load, depl, Ddisp : out STD_LOGIC;
           st : out STD_LOGIC_vector(3 downto 0));
end H2_fsm;

architecture Behavioral of H2_fsm is
    type state_type is (S0, S1, S2, S3, S4, S5); -- states of the FSM
    signal state : state_type := S0; -- current state
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            state <= S0; -- reset state
            TXready <= '0';
            depl <= '0';
            load <= '0';
            Ddisp <= '0';
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
                    load <= '0';
                    Ddisp <= '1';
                    if Dreq = '1' then
                        state <= S3;
                    end if;
                    
                when S3 =>
                    depl <= '1';
                    state <= S4;
                    
                when S4 =>
                    if num12 = '1' then
                        TXready <= '1';
                        depl <= '0';
                        state <= S5;
                    end if;
                    
                when S5 =>
                    if RXready = '1' then
                        TXready <= '0';
                        depl <= '0';
                        load <= '0';
                        Ddisp <= '0';
                        state <= S0;
                    else
                        state <= S5;
                    end if;
                    
                when others => NULL;
            end case;
        end if;
    end process;
    
    with state select st <=
        "0000" when S0,
        "0001" when S1,
        "0010" when S2,
        "0011" when S3,
        "0100" when S4,
        "0101" when S5;
end Behavioral;
