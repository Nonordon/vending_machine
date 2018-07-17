----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2018 08:34:53 PM
-- Design Name: 
-- Module Name: vending_machine - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vending_machine is
    Port (  clk     : in std_logic;
            sw      : in std_logic_vector(15 downto 0);
            btn     : in std_logic_vector(4 downto 0);
            --rst     : in std_logic;
            JA      : inout std_logic_vector(7 downto 0);
            JB      : inout std_logic_vector(7 downto 0);
            disp    : out std_logic_vector(11 downto 0);
            led     : out std_logic_vector(15 downto 0)
            );
           
end vending_machine;

architecture Behavioral of vending_machine is
    type STATE_TYPE is (idle, program, insertingNickel, insertingQuarter, insertingDollar, vend, returnChange);
    signal state        : STATE_TYPE;
    signal nickel       : std_logic;
    signal quarter      : std_logic;
    signal dollar       : std_logic;
    signal submit       : std_logic;
    signal reset        : std_logic;
    signal total        : unsigned(13 downto 0) := (others => '0'); --Non-bcd representation -- only 14 bits are needed to hold 9999
    signal ledo         : std_logic_vector(15 downto 0) := (others => '0');
    signal swi          : std_logic_vector(15 downto 0);
    --signal sevsego  : std_logic_vector(11 downto 0);
    signal displayVal   : std_logic_vector(15 downto 0) := (others => '0');
    signal dec          : std_logic_vector(3 downto 0) := (others => '0');
    signal keypad       : std_logic_vector(4 downto 0) := "11111";
    signal row          : std_logic_vector(4 downto 0) := "11111";
    signal col          : std_logic_vector(4 downto 0) := "11111";

    
    function binary_to_bcd( input : in unsigned(13 downto 0)) return std_logic_vector is
        variable bcd : unsigned(15 downto 0) := (others => '0');
        variable bin : unsigned(13 downto 0) := input;
        variable count : integer := 13;
        variable digit : integer;
        variable index_high : integer;
        variable index_low : integer;
        begin
            while (count >= 0) loop
                digit := 0;
                while (digit < 4) loop
                    index_high := (digit*4) + 3;
                    index_low := digit*4;
                    if (bcd(index_high downto index_low) > "0100") then
                        bcd(index_high downto index_low) := bcd(index_high downto index_low) + "0011";
                    end if;
                    digit := digit + 1;
                end loop;
                bcd := shift_left(bcd, 1);
                bcd(0) := bin(count);
                count := count - 1;
            end loop;
        return std_logic_vector(bcd);
    end function;
    
    function addMoney(value : in unsigned(13 downto 0); add : in unsigned(13 downto 0)) return unsigned is
        variable compVal : unsigned(15 downto 0) := "00" & value;
        begin
            compVal := compVal + add;
            if (compVal > "10011100001111") then 
                compVal := "0010011100001111";  --99
            elsif (compVal < value) then -- If this happened, then overflow occured
                compVal := "0010011100001111";
            end if; 
            return compVal(13 downto 0);
    end function;
    
begin 
    btnd    : entity work.btn_decoder port map(clk=>clk, btn=>btn, nickel=>nickel, quarter=>quarter, dollar=>dollar, submit=>submit, reset=>reset);
    lede    : entity work.led_encoder port map(clk=>clk, input=>ledo, led=>led);
    swd     : entity work.sw_decoder port map(clk=>clk, sw=>sw, output=>swi);
    sevsege : entity work.sevseg_encoder port map(clk=>clk, rst=>reset, input=>displayVal, dec=>dec, sevseg=>disp);
    kypdd   : entity work.kypd_decoder port map(clk=>clk, input=>JA, output=>keypad);
    process (clk, reset) -- Could need to be just btn, not include it, or seperate it from the btn vector
    begin    
        if (reset = '1') then
            -- Reset
--            JA <= (others => '0');
--            JB <= (others => '0');
            --sevsego <= (others => '0');
            ledo <= (others => '0');
            displayVal <= (others => '0');
            dec <= (others => '0');
            total <= (others => '0');
            state <= idle;
        elsif (rising_edge(clk)) then
            case state is
                when idle =>
                    if (swi(15) = '1') then
                        state <= program;
                    end if;
                    if (nickel = '1') then
                        state <= insertingNickel;
                    elsif (quarter = '1') then
                        state <= insertingQuarter;
                    elsif (dollar = '1') then
                        state <= insertingDollar;
                    elsif (submit = '1') then
                        state <= vend;
                    end if;
                    if (keypad /= "11111") then
                        if (row = "11111") then
                            row <= keypad;
                        elsif (col = "11111") then
                            col <= keypad;
                        else
                            row <= "11111";
                            col <= "11111";
                        end if;
                    end if;
                    --displayVal <= binary_to_bcd(total);
                    --dec <= "0100";
                    --if (row /= "11111") then
                        displayVal <= "0000" & row(3 downto 0) & "0000" & col(3 downto 0);
                    --end if;
                    --displayVal <= "000000000000" & keypad(3 downto 0);
                    dec <= "0000";
                when program =>
                    if (swi(15) = '0') then
                        state <= idle;
                    end if;
                when insertingNickel =>
                    total <= addMoney(total,"0101");
                    state <= idle;
                when insertingQuarter =>
                    total <= addMoney(total,"11001");
                    state <= idle;
                when insertingDollar =>
                    total <= addMoney(total,"1100100");
                    state <= idle;
                when vend =>
                    state <= idle;
                when others =>
                    state <= idle;
            end case;
        end if;
    end process;
    
end Behavioral;

 