----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/12/2018 08:40:20 PM
-- Design Name: 
-- Module Name: ascii_decoder - Behavioral
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

entity ascii_decoder is
    Port (  --clk     : in STD_LOGIC;
            input   : in std_logic_vector(3 downto 0);
            output  : out std_logic_vector(6 downto 0));
end ascii_decoder;

architecture Behavioral of ascii_decoder is

begin
    process (input)
    begin
        --if (rising_edge(clk)) then
        case input is
            when "0000" => -- 0
                output <= "1000000";
            when "0001" => -- 1
                output <= "1111001";
            when "0010" => -- 2
                output <= "0100100";
            when "0011" => -- 3
                output <= "0110000";
            when "0100" => -- 4
                output <= "0011001";
            when "0101" => -- 5
                output <= "0010010";
            when "0110" => -- 6
                output <= "0000010";
            when "0111" => -- 7
                output <= "1111000";
            when "1000" => -- 8
                output <= "0000000"; 
            when "1001" => -- 9
                output <= "0010000";
            when "1010" => -- a
                output <= "0100000";
            when "1011" => -- b
                output <= "0000011";
            when "1100" => -- c
                output <= "0100111";
            when "1101" => -- d
                output <= "0100001";
            when "1110" => -- e
                output <= "0000110";
            when "1111" => -- f
                output <= "0001110";
            when others => -- blank
                output <= "1111111";
        end case;
        --end if;
    end process;
end Behavioral;
