--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:32:51 02/09/2023
-- Design Name:   
-- Module Name:   C:/Users/pedro/Desktop/VHDL/datapath_ahmes/tb_ahmes.vhd
-- Project Name:  datapath_ahmes
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ahmes
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--

-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_ahmes IS
END tb_ahmes;
 
ARCHITECTURE behavior OF tb_ahmes IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ahmes
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         flags : OUT  std_logic_vector(4 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         hlt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal flags : std_logic_vector(4 downto 0);
   signal dout : std_logic_vector(7 downto 0);
   signal hlt : std_logic;

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ahmes PORT MAP (
          clk => clk,
          reset => reset,
          flags => flags,
          dout => dout,
          hlt => hlt
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '1';
		wait for clk_period*2;
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
