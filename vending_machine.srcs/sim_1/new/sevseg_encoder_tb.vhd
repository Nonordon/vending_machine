----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2018 02:05:20 PM
-- Design Name: 
-- Module Name: sevseg_encoder_tb - Behavioral
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

entity sevseg_encoder_tb is
--  Port ( );
end sevseg_encoder_tb;

architecture Behavioral of sevseg_encoder_tb is

    component sevseg_encoder
        port(   clk     : in STD_LOGIC;
                --input   : in STD_LOGIC_VECTOR(11 downto 0); 
                seg0    : in character;
                seg1    : in character;
                seg2    : in character;
                seg3    : in character;
                dec     : in STD_LOGIC_VECTOR(3 downto 0);
                sevseg  : out STD_LOGIC_VECTOR(11 downto 0)
            );
    end component;
    
    signal inclk    : STD_LOGIC;
--    signal inchar0  : character;
--    signal inchar1  : character;
--    signal inchar2  : character;
--    signal inchar3  : character;
    signal inString : String(1 to 4);
    signal indec    : STD_LOGIC_VECTOR(3 downto 0);
    signal outsevseg : STD_LOGIC_VECTOR(11 downto 0);
    
begin
    UUT :   sevseg_encoder port map (clk=>inclk, seg0=>inString(1), seg1=>inString(2), seg2=>inString(3), seg3=>inString(4), dec=>indec, sevseg=>outsevseg);
    
    stim_proc : process
    begin
        wait for 70 ns;
        inString <= "    ";
        indec <= "0000";
        wait for 500 ns;
        inString <= "0   ";
        wait for 500 ns;
        inString <= "10  ";
        wait for 500 ns;
        inString <= "210 ";
        wait for 500 ns;
        inString <= "3210";
        wait for 500 ns;
        inString <= "4321";
        wait for 500 ns;
        inString <= "5432";
        wait for 500 ns;
        inString <= "6543";
        wait for 500 ns;
        inString <= "7654";
        wait for 500 ns;
        inString <= "8765";
        wait for 500 ns;
        inString <= "9876";
        wait for 500 ns;
        inString <= "a987";
        wait for 500 ns;
        inString <= "ba98";
        wait for 500 ns;
        inString <= "cba9";
        wait for 500 ns;
        inString <= "dcba";
        wait for 500 ns;
        inString <= "edcb";
        wait for 500 ns;
        inString <= "fedc";
        wait for 500 ns;
        inString <= "-fed";
        wait for 500 ns;
        inString <= " -fe";
        wait for 500 ns;
        inString <= "  -f";
        wait for 500 ns;
        inString <= "   -";
        wait for 500 ns;
        inString <= "    ";
        wait for 500 ns;
        indec <= "0001";
        wait for 500 ns;
        indec <= "0011";
        wait for 500 ns;
        indec <= "0111";
        wait for 500 ns;
        indec <= "1111";
        wait;
    end process;
    
    clk_process : process
    begin
        inclk <= '0';
        wait for 5ns;
        inclk <= '1';
        wait for 5ns;
    end process;
end Behavioral;
