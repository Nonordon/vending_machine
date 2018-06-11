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
    Port (  clk     : in STD_LOGIC;
            input   : in STD_LOGIC_VECTOR(11 downto 0); 
            sevseg  : out STD_LOGIC_VECTOR(11 downto 0)
            );
end sevseg_encoder;

architecture Behavioral of sevseg_encoder is

begin
    process (clk) -- Could need to be just btn, not include it, or seperate it from the btn vector
    begin
        if (rising_edge(clk)) then
            sevseg <= input;
        end if;
    end process;
end Behavioral;
