----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2018 11:14:59 AM
-- Design Name: 
-- Module Name: sevseg_encoder - Behavioral
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

entity sevseg_encoder is
    Generic ( delay : integer := 10000);
    Port (  clk     : in std_logic;
            input   : in std_logic_vector(15 downto 0); 
            rst     : in std_logic;
            dec     : in std_logic_vector(3 downto 0);
            sevseg  : out std_logic_vector(11 downto 0)
            );
end sevseg_encoder;

architecture Behavioral of sevseg_encoder is
    type STATE_TYPE is (an0, an1, an2, an3);
    signal state  : STATE_TYPE := an0;
    signal temp0  : std_logic_vector(6 downto 0);
    signal temp1  : std_logic_vector(6 downto 0);
    signal temp2  : std_logic_vector(6 downto 0);
    signal temp3  : std_logic_vector(6 downto 0);
    signal count : integer range 0 to delay := delay;
begin
    decoder0    : entity work.ascii_decoder port map(input=>input(3 downto 0), output=>temp0);
    decoder1    : entity work.ascii_decoder port map(input=>input(7 downto 4), output=>temp1);
    decoder2    : entity work.ascii_decoder port map(input=>input(11 downto 8), output=>temp2);
    decoder3    : entity work.ascii_decoder port map(input=>input(15 downto 12), output=>temp3);
    
    process (clk, rst)
    begin
        if (rst = '1') then
            count <= delay;
            state <= an0;
            sevseg <= "111111111111";
        elsif (rising_edge(clk)) then
            if (count < delay) then
                count <= count + 1;
            else
                case state is
                    when an0 =>
                        sevseg(6 downto 0) <= temp0;
                        sevseg(7) <= not dec(0);
                        sevseg(11 downto 8) <= "1110";
                        count <= 0;
                        state <= an1;
                    when an1 =>
                        sevseg(6 downto 0) <= temp1;
                        sevseg(7) <= not dec(1);
                        sevseg(11 downto 8) <= "1101";
                        count <= 0;
                        state <= an2;
                    when an2 =>
                        sevseg(6 downto 0) <= temp2;
                        sevseg(7) <= not dec(2);
                        sevseg(11 downto 8) <= "1011";
                        count <= 0;
                        state <= an3;
                    when an3 =>
                        sevseg(6 downto 0) <= temp3;
                        sevseg(7) <= not dec(3);
                        sevseg(11 downto 8) <= "0111";
                        state <= an0;
                        count <= 0;
                end case;
            end if;
        end if;
    end process;
        
end Behavioral;
