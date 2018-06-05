----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2018 11:39:46 AM
-- Design Name: 
-- Module Name: seven_segment - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_segment is
  Port (NUMBER: in STD_LOGIC_VECTOR (3 downto 0);
       -- SELECTOR: in STD_LOGIC_VECTOR (2 downto 0);
        DOT: out STD_LOGIC;
        ANODE: out STD_LOGIC_VECTOR (7 downto 0);
        HEX0: out STD_LOGIC_VECTOR (6 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is
    SIGNAL digit_in : STD_LOGIC_VECTOR (6 downto 0);
    SIGNAL digit_dot : STD_LOGIC;
    SIGNAL digit_anode : STD_LOGIC_VECTOR(7 downto 0);
begin
   process (NUMBER)
    begin
    digit_dot <= '1';
   -- digit_anode <= '0';
    digit_anode <= "00000011";
    case NUMBER is
        when "0000" => digit_in <= "1111110";
        when "0001" => digit_in <= "0110000";
        when "0010" => digit_in <= "1101101";
        when "0011" => digit_in <= "1111001";
        when "0100" => digit_in <= "0110011";
        when "0101" => digit_in <= "1011011";
        when "0110" => digit_in <= "1011111";
        when "0111" => digit_in <= "1110000";
        when "1000" => digit_in <= "1111111";
        when "1001" => digit_in <= "1111011";
        when OTHERS => digit_in <= "XXXXXXX";
    end case;
--    case SELECTOR is
--            when "000" => digit_anode <= "00000001";
--            when "001" => digit_anode <= "00000010";
--            when "010" => digit_anode <= "00000100";
--            when "011" => digit_anode <= "00001000";
--            when "100" => digit_anode <= "00010000";
--            when "101" => digit_anode <= "00100000";
--            when "110" => digit_anode <= "01000000";
--            when "111" => digit_anode <= "10000000";
--     end case;
   end process;
   HEX0 <= not digit_in;
   DOT <= not digit_dot;
   ANODE <= not digit_anode;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity two_number_split is
  Port (NUMBER: in STD_LOGIC_VECTOR (6 downto 0);
       -- SELECTOR: in STD_LOGIC_VECTOR (2 downto 0);
        LEFT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0));
        RIGHT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0));
end two_number_split;

architecture Behavioral of two_number_split is
    SIGNAL value : STD_LOGIC_VECTOR (6 downto 0);
    variable num_subtract: STD_LOGIC_VECTOR (3 downto 0):="0000";
begin
   process (NUMBER)
    begin
        if NUMBER < "0001010" then
            LEFT_DIGIT <= "0000";
            RIGHT_DIGIT <= NUMBER (3 downto 0);
        else if NUMBER >= "0001010" AND NUMBER <= "1100011" then
        
        else if NUMBER > "1100011" then
            LEFT_DIGIT <= "XXXX";
            RIGHT_DIGIT <= "XXXX";
        end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display_2pos is
  Port (NUMBER: in STD_LOGIC_VECTOR (6 downto 0);
       -- SELECTOR: in STD_LOGIC_VECTOR (2 downto 0);
        DOT: out STD_LOGIC;
        ANODE: out STD_LOGIC_VECTOR (7 downto 0);
        HEX0: out STD_LOGIC_VECTOR (6 downto 0));
        HEX1: out STD_LOGIC_VECTOR (6 downto 0));
end display_2pos;

architecture Behavioral of display_2pos is
    SIGNAL digit_in : STD_LOGIC_VECTOR (6 downto 0);
    SIGNAL digit_dot : STD_LOGIC;
    SIGNAL digit_anode : STD_LOGIC_VECTOR(7 downto 0);
begin
   process (NUMBER)
    begin
    digit_dot <= '1';
   -- digit_anode <= '0';
    digit_anode <= "00000011";
    case NUMBER is
        when "0000" => digit_in <= "1111110";
        when "0001" => digit_in <= "0110000";
        when "0010" => digit_in <= "1101101";
        when "0011" => digit_in <= "1111001";
        when "0100" => digit_in <= "0110011";
        when "0101" => digit_in <= "1011011";
        when "0110" => digit_in <= "1011111";
        when "0111" => digit_in <= "1110000";
        when "1000" => digit_in <= "1111111";
        when "1001" => digit_in <= "1111011";
        when OTHERS => digit_in <= "XXXXXXX";
    end case;
--    case SELECTOR is
--            when "000" => digit_anode <= "00000001";
--            when "001" => digit_anode <= "00000010";
--            when "010" => digit_anode <= "00000100";
--            when "011" => digit_anode <= "00001000";
--            when "100" => digit_anode <= "00010000";
--            when "101" => digit_anode <= "00100000";
--            when "110" => digit_anode <= "01000000";
--            when "111" => digit_anode <= "10000000";
--     end case;
   end process;
   HEX0 <= not digit_in;
   DOT <= not digit_dot;
   ANODE <= not digit_anode;
end Behavioral;
