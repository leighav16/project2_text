----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2017 07:14:59 PM
-- Design Name: 
-- Module Name: MY_CHAR_DRIVER - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;       -- For unsigned()
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MY_CHAR_DRIVER is
PORT( hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
      ASCII_CHAR : out STD_LOGIC_VECTOR(6 downto 0));
end MY_CHAR_DRIVER;

architecture Behavioral of MY_CHAR_DRIVER is
signal char_col : std_logic_vector(6 downto 0);
signal char_row : std_logic_vector(5 downto 0);
begin
 char_col <= hcount(9 downto 3);  -- Character column in [0,79]
 char_row <= vcount(8 downto 3);  -- Character row in [0,59]
-- ASCII_CHAR <= char_row + char_col;
ASCII_CHAR <= "0000001";


end Behavioral;
