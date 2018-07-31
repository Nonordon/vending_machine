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
    Generic ( delay : integer := 10000);
    Port (  clk     : in std_logic;
            row     : in std_logic_vector(3 downto 0);
            col     : out std_logic_vector(3 downto 0);
            valid   : out std_logic;
            output  : out std_logic_vector(3 downto 0)
            );
end kypd_decoder;

architecture Behavioral of kypd_decoder is
    type STATE_TYPE is (col4, col3, col2, col1);
    signal state  : STATE_TYPE := col4;
    signal count : integer range 0 to 4*delay + 8 := 0;
    signal temp :   std_logic_vector(3 downto 0);

begin
    --debouncer : entity work.kypd_debouncer port map(clk=>clk, input=>input, output=>temp);
    debouncer0    : entity work.debouncer port map(clk=>clk, valid=>'0', input=>row(0), output=>temp(0));
    debouncer1    : entity work.debouncer port map(clk=>clk, valid=>'0', input=>row(1), output=>temp(1));
    debouncer2    : entity work.debouncer port map(clk=>clk, valid=>'0', input=>row(2), output=>temp(2));
    debouncer3    : entity work.debouncer port map(clk=>clk, valid=>'0', input=>row(3), output=>temp(3));
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (count = delay) then
                col <= "0111";
            elsif (count = delay + 8) then
                if (temp(3) = '0') then
                    output <= "0001";           -- 1
                    valid <= '1';
                elsif (temp(2) = '0') then
                    output <= "0100";           -- 4
                    valid <= '1';
                elsif (temp(1) = '0') then
                    output <= "0111";           -- 7
                    valid <= '1';
                elsif (temp(0) = '0') then
                    output <= "0000";           -- 0
                    valid <= '1';
                end if;
            elsif (count = 2*delay) then
                col <= "1011";
            elsif (count = 2*delay + 8) then
                if (temp(3) = '0') then
                    output <= "0010";           -- 2
                    valid <= '1';
                elsif (temp(2) = '0') then
                    output <= "0101";           -- 5
                    valid <= '1';
                elsif (temp(1) = '0') then
                    output <= "1000";           -- 8
                    valid <= '1';
                elsif (temp(0) = '0') then
                    output <= "1111";           -- f
                    valid <= '1';
                end if;
            elsif (count = 3*delay) then
                col <= "1101";
            elsif (count = 3*delay + 8) then
                if (temp(3) = '0') then
                    output <= "0011";           -- 3
                    valid <= '1';
                elsif (temp(2) = '0') then
                    output <= "0110";           -- 6
                    valid <= '1';
                elsif (temp(1) = '0') then
                    output <= "1001";           -- 9
                    valid <= '1';
                elsif (temp(0) = '0') then
                    output <= "1110";           -- e
                    valid <= '1';
                end if;
            elsif (count = 4*delay) then
                    col <= "1110";
            elsif (count = 4*delay + 8) then
                if (temp(3) = '0') then
                    output <= "1010";           -- a 
                    valid <= '1';
                elsif (temp(2) = '0') then
                    output <= "1011";           -- b
                    valid <= '1';
                elsif (temp(1) = '0') then
                    output <= "1100";           -- c
                    valid <= '1';
                elsif (temp(0) = '0') then
                    output <= "1101";           -- d
                    valid <= '1';
                end if;
                count <= 0;
            else
                valid <= '0';
            end if;
            count <= count + 1;
        end if;
    end process;
end Behavioral;
