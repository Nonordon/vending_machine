----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2018 01:27:50 AM
-- Design Name: 
-- Module Name: kypd_debouncer - Behavioral
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

entity kypd_debouncer is
    Generic (delay : integer := 5000000
            );
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end kypd_debouncer;

architecture Behavioral of kypd_debouncer is
    signal val1 : std_logic_vector(7 downto 0);
    signal val2 : std_logic_vector(7 downto 0);
    signal val3 : std_logic_vector(7 downto 0);
    signal counter : integer range 0 to delay := delay;

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            val3 <= val2;
            val2 <= val1;
            val1 <= input;
            if (counter = 0) or (counter < delay) then --and ((val3 and val2 and val1) = "11111111"))) then
                counter <= counter + 1;
                output <= "11111111";
            elsif (counter = delay) then --and (val3 and val2 and val1) = '1') then
                output <= input;
                counter <= 0;
            end if;
        end if;
    end process;

end Behavioral;
