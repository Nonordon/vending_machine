----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2018 12:41:38 AM
-- Design Name: 
-- Module Name: kypd_decoder - Behavioral
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

entity kypd_decoder is
    Port (  clk     : in std_logic;
            input   : in std_logic_vector(7 downto 0);
            output  : out std_logic_vector(4 downto 0)
            );
end kypd_decoder;

architecture Behavioral of kypd_decoder is
-- input(0) = Col4
-- input(1) = Col3
-- input(2) = Col2
-- input(3) = Col1
-- input(4) = Row4
-- input(5) = Row3
-- input(6) = Row2
-- input(7) = Row1
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (input(7) = '1') then
                if (input(3) = '0') then
                    output <= "00001";           -- 1
                elsif (input(2) = '0') then
                    output <= "00010";           -- 2
                elsif (input(1) = '0') then
                    output <= "00011";           -- 3
                elsif (input(0) = '0') then
                    output <= "01010";           -- a
                end if;
            elsif (input(6) = '1') then
                if (input(3) = '0') then
                    output <= "00100";           -- 4 
                elsif (input(2) = '0') then
                    output <= "00101";           -- 5
                elsif (input(1) = '0') then
                    output <= "00110";           -- 6
                elsif (input(0) = '0') then
                    output <= "01011";           -- b
                end if;
            elsif (input(5) = '1') then
                if (input(3) = '0') then
                    output <= "00111";           -- 7 
                elsif (input(2) = '0') then
                    output <= "01000";           -- 8
                elsif (input(1) = '0') then
                    output <= "01001";           -- 9
                elsif (input(0) = '0') then
                    output <= "01100";           -- c
                end if;
            elsif (input(5) = '1') then
                if (input(3) = '0') then
                    output <= "00000";           -- 0 
                elsif (input(2) = '0') then
                    output <= "01111";           -- f
                elsif (input(1) = '0') then
                    output <= "01110";           -- e
                elsif (input(0) = '0') then
                    output <= "01101";           -- d
                end if;
            else 
                output <= "11111";
            end if;
        end if;
    end process;
end Behavioral;
