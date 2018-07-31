----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/20/2018 11:12:27 PM
-- Design Name: 
-- Module Name: debouncer - Behavioral
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

entity debouncer is
    Generic (delay : integer := 5000000
            );
    Port (  clk     : in std_logic;
            valid   : in std_logic;
            input   : in std_logic;
            output  : out std_logic
           );
end debouncer;

architecture Behavioral of debouncer is
    signal val1 : std_logic;
    signal val2 : std_logic;
    signal val3 : std_logic;
    signal counter : integer range 0 to delay := delay;

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            val3 <= val2;
            val2 <= val1;
            val1 <= input;
            if ((counter = 0) or ((counter < delay) and ((val3 and val2 and val1) = not valid))) then
                counter <= counter + 1;
                output <= not valid;
            elsif ((counter = delay) and (val3 and val2 and val1) = valid) then
                output <= valid;
                counter <= 0;
            end if;
        end if;
    end process;
end Behavioral;
