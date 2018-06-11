----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2018 08:34:53 PM
-- Design Name: 
-- Module Name: vending_machine - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vending_machine is
    Port (  clk     : in STD_LOGIC;
            sw      : in STD_LOGIC_VECTOR(15 downto 0);
            btn     : in STD_LOGIC_VECTOR(4 downto 0);
            --rst     : in STD_LOGIC;
            JA      : inout STD_LOGIC_VECTOR(7 downto 0);
            JB      : inout STD_LOGIC_VECTOR(7 downto 0);
            disp    : out STD_LOGIC_VECTOR(11 downto 0);
            led     : out STD_LOGIC_VECTOR(15 downto 0)
            );
           
end vending_machine;

architecture Behavioral of vending_machine is
    type STATE_TYPE is (idle, program);
    signal state    : STATE_TYPE;
    signal btno     : STD_LOGIC_VECTOR(4 downto 0);
    signal ledi     : STD_LOGIC_VECTOR(15 downto 0);
    signal swi      : STD_LOGIC_VECTOR(15 downto 0);
    signal sevsego  : STD_LOGIC_VECTOR(11 downto 0);
begin 
    btnd: entity work.btn_decoder port map(clk=>clk, btn=>btn, output=>btno);
    lede: entity work.led_encoder port map(clk=>clk, input=>ledi, led=>led);
    swd: entity work.sw_decoder port map(clk=>clk, sw=>sw, output=>swi);
    sevsege: entity work.sevseg_encoder port map(clk=>clk, input=>sevsego, sevseg=>disp);
    process (clk, btno(4)) -- Could need to be just btn, not include it, or seperate it from the btn vector
    begin
        if (btno(4) = '1') then
            -- Reset
--            JA <= (others => '0');
--            JB <= (others => '0');
            sevsego <= (others => '0');
            ledi <= (others => '0');
            state <= idle;
        elsif (rising_edge(clk)) then
            case state is
                when idle =>
                    if (swi(15) = '1') then
                        state <= program;
                    end if;
                    ledi <= "0000000000000000";
                    --ledi(14 downto 0) <= swi(14 downto 0);
                when program =>
                    if (swi(15) = '0') then
                        state <= idle;
                    end if;
                    ledi <= "1111111111111111";
                when others =>
                    state <= idle;
            end case;
        end if;
    end process;
end Behavioral;