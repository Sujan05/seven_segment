----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/23/2018 11:11:44 PM
-- Design Name: 
-- Module Name: display_2pos - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity two_number_split is
  Port (NUMBER: in STD_LOGIC_VECTOR (6 downto 0);
        LEFT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0);
        RIGHT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0));
end two_number_split;
--Binary to BCD converter for 0 to 99 
architecture Behavioral of two_number_split is
  begin
     process (NUMBER)
      variable z : STD_LOGIC_VECTOR(14 downto 0);
           begin
             for i in 0 to 14 loop
               z(i) := '0';
             end loop;
             z(9 downto 3) := NUMBER;
             for i in 0 to 3 loop
               if z(10 downto 7) > 4 then
                 z(10 downto 7) := z(10 downto 7) + 3;
               end if;
               if z(14 downto 11) > 4 then
                 z(14 downto 11) := z(14 downto 11) + 3;
               end if;
               z(14 downto 1) := z(13 downto 0);
             end loop;
             LEFT_DIGIT <= z(14 downto 11);
             RIGHT_DIGIT <= z(10 downto 7);
           end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

--This is Top module
entity display_2pos is
  Port (NUMBER: in STD_LOGIC_VECTOR (6 downto 0);
        clk_fpga: in STD_LOGIC;
        DOT: out STD_LOGIC;
        ANODE: out STD_LOGIC_VECTOR (7 downto 0);
        HEX0: out STD_LOGIC_VECTOR (6 downto 0));
end display_2pos;

architecture Behavioral of display_2pos is
  component two_number_split
  Port (NUMBER: in STD_LOGIC_VECTOR (6 downto 0);
        LEFT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0);
        RIGHT_DIGIT: out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  component seven_segment
  Port (NUMBER: in STD_LOGIC_VECTOR (3 downto 0);
        HEX0: out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  component clock_module
  Port ( 
          clk: in STD_LOGIC;
          output: out STD_LOGIC
      );
  end component;
    SIGNAL clk: STD_LOGIC;
    SIGNAL digit_dot : STD_LOGIC;
    SIGNAL digit_anode : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL HEX0_out: STD_LOGIC_VECTOR (6 downto 0);
    SIGNAL HEX1_out: STD_LOGIC_VECTOR (6 downto 0);
    SIGNAL left_out: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL right_out: STD_LOGIC_VECTOR(3 downto 0);
begin
  digit_dot <= '1';
  clock_generation: clock_module port map(clk_fpga, clk);
  step1: two_number_split port map(NUMBER, left_out, right_out);
  step2_left: seven_segment port map(left_out,HEX1_out);
  step2_right: seven_segment port map(right_out,HEX0_out);
  
  process(clk,NUMBER)
  begin
    if clk = '1' then
        HEX0 <= HEX0_out;
        digit_anode <= "00000010";
    else if clk = '0' then
        HEX0 <= HEX1_out;
        digit_anode <= "00000001";
     end if;
    end if;
    DOT <= not digit_dot;
    ANODE <= not digit_anode;
  end process;
end Behavioral;
