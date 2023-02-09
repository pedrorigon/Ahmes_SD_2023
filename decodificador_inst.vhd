----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:12 02/07/2023 
-- Design Name: 
-- Module Name:    decodificador_inst - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodificador_inst is
	port (saida_RI : in STD_LOGIC_VECTOR (7 downto 0);
			inst_NOP : out  STD_LOGIC;
			inst_STA : out  STD_LOGIC;
			inst_LDA : out  STD_LOGIC;
			inst_ADD : out  STD_LOGIC;
			inst_OR : out  STD_LOGIC;
			inst_AND : out  STD_LOGIC;
			inst_NOT : out  STD_LOGIC;
			inst_SUB : out  STD_LOGIC;
			inst_JMP : out  STD_LOGIC;
			inst_JN : out  STD_LOGIC;
			inst_JP : out  STD_LOGIC;
			inst_JV : out  STD_LOGIC;
			inst_JNV : out  STD_LOGIC;
			inst_JZ : out  STD_LOGIC;
			inst_JNZ : out  STD_LOGIC;
			inst_JC : out  STD_LOGIC;
			inst_JNC : out  STD_LOGIC;
			inst_JB : out  STD_LOGIC;
			inst_JNB : out  STD_LOGIC;
			inst_SHR : out  STD_LOGIC;
			inst_SHL : out  STD_LOGIC;
			inst_ROR : out  STD_LOGIC;
			inst_ROL : out  STD_LOGIC;
			inst_HLT : out  STD_LOGIC);
end decodificador_inst;

architecture Behavioral of decodificador_inst is

begin

process(saida_RI)
begin
	inst_NOP <= '0';
	inst_STA <= '0';
	inst_LDA <= '0';
	inst_ADD <= '0';
	inst_OR <= '0';
	inst_AND <= '0';
	inst_NOT <= '0';
	inst_SUB <= '0';
	inst_JMP <= '0';
	inst_JN <= '0';
	inst_JP <= '0';
	inst_JV <= '0';
	inst_JNV <= '0';
	inst_JZ <= '0';
	inst_JNZ <= '0';
	inst_JC <= '0';
	inst_JNC <= '0';
	inst_JB <= '0';
	inst_JNB <= '0';
	inst_SHR <= '0';
	inst_SHL <= '0';
	inst_ROR <= '0';
	inst_ROL <= '0';
	inst_HLT <= '0';
	case saida_RI is
		when "00000000" =>
			inst_NOP <= '1';
		when "00010000" =>
			inst_STA <= '1';
		when "00100000" =>
			inst_LDA <= '1';
		when "00110000" =>
			inst_ADD <= '1';
		when "01000000" =>
			inst_OR <= '1';
		when "01010000" =>
			inst_AND <= '1';
		when "01100000" =>
			inst_NOT <= '1';
		when "01110000" =>
			inst_SUB <= '1';
		when "10000000" =>
			inst_JMP <= '1';
		when "10010000" =>
			inst_JN <= '1';
		when "10010100" =>
			inst_JP <= '1';
		when "10011000" =>
			inst_JV <= '1';
		when "10011100" =>
			inst_JNV <= '1';
		when "10100000" =>
			inst_JZ <= '1';
		when "10100100" =>
			inst_JNZ <= '1';
		when "10110000" =>
			inst_JC <= '1';
		when "10110100" =>
			inst_JNC <= '1';
		when "10111000" =>
			inst_JB <= '1';
		when "10111100" =>
			inst_JNB <= '1';
		when "11100000" =>
			inst_SHR <= '1';
		when "11100001" =>
			inst_SHL <= '1';
		when "11100010" =>
			inst_ROR <= '1';
		when "11100011" =>
			inst_ROL <= '1';
		when "11110000" =>
			inst_HLT <= '1';
		when others =>
			inst_HLT <= '1';
	end case;
end process;

end Behavioral;

