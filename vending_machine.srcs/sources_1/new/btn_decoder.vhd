----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2018 11:14:59 AM
-- Design Name: 
-- Module Name: btn_decoder - Behavioral
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

entity btn_decoder is
    Port (  clk     : in std_logic;
            btn     : in std_logic_vector(4 downto 0);
            reset   : out std_logic;
            nickel  : out std_logic;
            quarter : out std_logic;
            dollar  : out std_logic;
            submit  : out std_logic
            );
end btn_decoder;

architecture Behavioral of btn_decoder is

begin
    debouncer0    : entity work.debouncer port map(clk=>clk, input=>btn(0), output=>nickel);
    debouncer1    : entity work.debouncer port map(clk=>clk, input=>btn(1), output=>quarter);
    debouncer2    : entity work.debouncer port map(clk=>clk, input=>btn(2), output=>dollar);
    debouncer3    : entity work.debouncer port map(clk=>clk, input=>btn(3), output=>submit);
    --debouncer4    : entity work.debouncer port map(clk=>clk, input=>btn(4), output=>reset);

    process (btn(4))
    begin
        reset <= btn(4);
    end process;
end Behavioral;
