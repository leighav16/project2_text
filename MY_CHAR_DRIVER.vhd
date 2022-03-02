library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;       -- For unsigned()
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MY_CHAR_DRIVER is
PORT( hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
      ASCII_CHAR : out STD_LOGIC_VECTOR(6 downto 0));
end MY_CHAR_DRIVER;

architecture Behavioral of MY_CHAR_DRIVER is

signal char_col : std_logic_vector(4 downto 0) := "00000";
signal char_row : std_logic_vector(3 downto 0) := "0000";
begin
process(vcount, hcount) begin

    char_col <= hcount(9 downto 5); -- Character column in [0,19]
    char_row <= vcount(8 downto 5); -- Character row in [0,14]
    
    if((char_col = 2) and (char_row = 0)) then
        ASCII_CHAR <= "0000000";        -- T
    elsif((char_col = 3) and (char_row = 0)) then
        ASCII_CHAR <= "0000001";        -- H    
    elsif((char_col = 4) and (char_row = 0)) then
        ASCII_CHAR <= "0000010";        -- E    
    elsif((char_col = 5) and (char_row = 0)) then
        ASCII_CHAR <= "0000011";        -- S
    elsif((char_col = 6) and (char_row = 0)) then
        ASCII_CHAR <= "0000100";        -- E
    elsif((char_col = 7) and (char_row = 0)) then
        ASCII_CHAR <= "0000101";        -- U    
    elsif((char_col = 8) and (char_row = 0)) then
        ASCII_CHAR <= "0000110";        -- S    
    elsif((char_col = 9) and (char_row = 0)) then
        ASCII_CHAR <= "0000111";        -- space  
    elsif((char_col = 10) and (char_row = 0)) then
        ASCII_CHAR <= "0001000";        -- A
    elsif((char_col = 11) and (char_row = 0)) then
        ASCII_CHAR <= "0001001";        -- N    
    elsif((char_col = 12) and (char_row = 0)) then
        ASCII_CHAR <= "0001010";        -- D    
    elsif((char_col = 13) and (char_row = 0)) then
        ASCII_CHAR <= "0001011";        -- space
    elsif((char_col = 14) and (char_row = 0)) then
        ASCII_CHAR <= "0001100";        -- T
    elsif((char_col = 15) and (char_row = 0)) then
        ASCII_CHAR <= "0001101";        -- H    
    elsif((char_col = 16) and (char_row = 0)) then
        ASCII_CHAR <= "0001110";        -- E       
                  
    -- SECOND ROW
    elsif((char_col = 5) and (char_row = 14)) then
        ASCII_CHAR <= "0010000";        -- M
    elsif((char_col = 6) and (char_row = 14)) then
        ASCII_CHAR <= "0010001";        -- I    
    elsif((char_col = 7) and (char_row = 14)) then
        ASCII_CHAR <= "0010010";        -- N    
    elsif((char_col = 8) and (char_row = 14)) then
        ASCII_CHAR <= "0010011";        -- O
    elsif((char_col = 9) and (char_row = 14)) then
        ASCII_CHAR <= "0010100";        -- T
    elsif((char_col = 10) and (char_row = 14)) then
        ASCII_CHAR <= "0010101";        -- A    
    elsif((char_col = 11) and (char_row = 14)) then
        ASCII_CHAR <= "0010110";        -- U    
    elsif((char_col = 12) and (char_row = 14)) then
        ASCII_CHAR <= "0010111";        -- R                   
                  
    else
        ASCII_CHAR <= "0000111";        -- fill everything else with spaces
    end if;

end process;
end Behavioral;