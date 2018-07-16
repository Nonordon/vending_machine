----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2018 02:59:14 PM
-- Design Name: 
-- Module Name: vending_machine_tb - Behavioral
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

entity vending_machine_tb is
--  Port ( );
end vending_machine_tb;

architecture Behavioral of vending_machine_tb is
    component vending_machine
        port (  clk     : in STD_LOGIC;
                sw      : in STD_LOGIC_VECTOR(15 downto 0);
                btn     : in STD_LOGIC_VECTOR(4 downto 0);
                JA      : inout STD_LOGIC_VECTOR(7 downto 0);
                JB      : inout STD_LOGIC_VECTOR(7 downto 0);
                disp    : out STD_LOGIC_VECTOR(11 downto 0);
                led     : out STD_LOGIC_VECTOR(15 downto 0)
            );
    end component;
    
    signal inclk    : STD_LOGIC;
    signal insw     : STD_LOGIC_VECTOR(15 downto 0);
    signal inbtn    : STD_LOGIC_VECTOR(4 downto 0);
    signal inJA     : STD_LOGIC_VECTOR(7 downto 0);
    signal inJB     : STD_LOGIC_VECTOR(7 downto 0);
    signal outdisp  : STD_LOGIC_VECTOR(11 downto 0);
    signal outled   : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    UUT : vending_machine port map (clk=>inclk, sw=>insw, btn=>inbtn, JA=>inJA, JB=>inJB, disp=>outdisp, led=>outled);

    stim_proc : process
    begin
        wait for 3 ns;
        inbtn <= "10000";
        insw <= "0000000000000000";
        inJA <= "00000000";
        inJB <= "00000000";
        wait for 100 ns;
        inbtn <= "00000";
        wait for 1000 ns;
        insw <= "1000000000000000";
        wait for 1000 ns;
        insw <= "0000000000000000";
        wait;
    end process;

    clk_process : process
    begin
        inclk <= '0';
        wait for 5 ns;
        inclk <= '1';
        wait for 5 ns;
    end process;
end Behavioral;
