library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_To_HDMI is
Port (clk_100MHz,reset : in STD_LOGIC; 
      HDMI_clk_p,HDMI_clk_n : out STD_LOGIC;
      HDMI_tx_p,HDMI_tx_n : out STD_LOGIC_VECTOR(2 downto 0));
end VGA_To_HDMI;

architecture Behavioral of VGA_To_HDMI is
-- -----------------------------------------------------------------
component clk_wiz_0
port(clk_in1,reset : in std_logic; clk_out1,clk_out2,locked : out std_logic);
end component;

component vga_controller_640_60 is
port(rst,pixel_clk : in std_logic; HS,VS,blank : out std_logic;
     hcount,vcount : out std_logic_vector(10 downto 0));
end component;

component MY_CHAR_DRIVER is
PORT( hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
      ASCII_CHAR : out STD_LOGIC_VECTOR(6 downto 0));
end component;

component CHAR_GEN is
PORT(clk25, blank : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
     ASCII_CHAR : in STD_LOGIC_VECTOR(6 downto 0);
     R3,R2,R1,R0,G3,G2,G1,G0,B3,B2,B1,B0 : out STD_LOGIC);
end component;

COMPONENT hdmi_tx_0
  PORT (
    pix_clk : IN STD_LOGIC;
    pix_clkx5 : IN STD_LOGIC;
    pix_clk_locked : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    red : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    green : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    blue : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    hsync : IN STD_LOGIC;
    vsync : IN STD_LOGIC;
    vde : IN STD_LOGIC;
    aux0_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aux1_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aux2_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ade : IN STD_LOGIC;
    TMDS_CLK_P : OUT STD_LOGIC;
    TMDS_CLK_N : OUT STD_LOGIC;
    TMDS_DATA_P : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    TMDS_DATA_N : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
END COMPONENT;
-- --------------------------------------------------------------------
signal CLK_25MHz,CLK_125MHz,blank,locked : STD_LOGIC;
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
signal HSYNC, VSYNC : STD_LOGIC;
signal RED3,RED2,RED1,RED0 : STD_LOGIC;
signal GREEN3,GREEN2,GREEN1,GREEN0 : STD_LOGIC;
signal BLUE3,BLUE2,BLUE1,BLUE0 : STD_LOGIC;
signal vde : STD_LOGIC;
signal RED, GREEN, BLUE : STD_LOGIC_VECTOR(3 downto 0);
signal ASCII_CHAR : STD_LOGIC_VECTOR(6 downto 0);

begin
-- ------ Cannot pass these directly during instantiation ------
vde <= not blank;
RED <= (RED3 & RED2 & RED1 & RED0);
GREEN <= (GREEN3 & GREEN2 & GREEN1 & GREEN0);
BLUE <= (BLUE3 & BLUE2 & BLUE1 & BLUE0);
-- --------------------------------------------------------------

C1: clk_wiz_0 PORT MAP (clk_out1 => CLK_25MHz, clk_out2 => CLK_125MHz, reset => reset, locked => locked, clk_in1 => clk_100MHz);  

V1 : vga_controller_640_60 PORT MAP (pixel_clk => CLK_25MHz, rst => reset, HS => HSYNC, VS => VSYNC, blank => blank, hcount => hcount, 
                                     vcount => vcount);

D1 : MY_CHAR_DRIVER PORT MAP (hcount => hcount, vcount => vcount, ASCII_CHAR => ASCII_CHAR);

G1 : CHAR_GEN PORT MAP (clk25 => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount, ASCII_CHAR => ASCII_CHAR, 
                        R3 => RED3, R2 => RED2, R1 => RED1, R0 => RED0, G3 => GREEN3, G2 => GREEN2, G1 => GREEN1, G0 => GREEN0, 
                        B3 => BLUE3, B2 => BLUE2, B1 => BLUE1, B0 => BLUE0);
                        
H1 : hdmi_tx_0 PORT MAP (pix_clk => CLK_25MHz, pix_clkx5 => CLK_125MHz, pix_clk_locked => locked, rst => reset,
                         red => RED, green => GREEN, blue => BLUE, hsync => HSYNC, vsync => VSYNC, vde => vde,
                         aux0_din => X"0", aux1_din => X"0", aux2_din => X"0", ade => '0',
                         TMDS_CLK_P => HDMI_clk_p, TMDS_CLK_N => HDMI_clk_n, TMDS_DATA_P => HDMI_tx_p, TMDS_DATA_N => HDMI_tx_n);

end Behavioral;