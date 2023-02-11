----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:05:19 02/02/2023 
-- Design Name: 
-- Module Name:    unidade_de_controle - Behavioral 
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

entity unidade_de_controle is
    Port ( clk : in STD_LOGIC;
			  reset : in STD_LOGIC;
			  inst_NOP : in  STD_LOGIC;
           inst_STA : in  STD_LOGIC;
           inst_LDA : in  STD_LOGIC;
           inst_ADD : in  STD_LOGIC;
           inst_OR : in  STD_LOGIC;
           inst_AND : in  STD_LOGIC;
           inst_NOT : in  STD_LOGIC;
           inst_SUB : in  STD_LOGIC;
           inst_JMP : in  STD_LOGIC;
           inst_JN : in  STD_LOGIC;
           inst_JP : in  STD_LOGIC;
           inst_JV : in  STD_LOGIC;
           inst_JNV : in  STD_LOGIC;
           inst_JZ : in  STD_LOGIC;
           inst_JNZ : in  STD_LOGIC;
           inst_JC : in  STD_LOGIC;
           inst_JNC : in  STD_LOGIC;
           inst_JB : in  STD_LOGIC;
           inst_JNB : in  STD_LOGIC;
           inst_SHR : in  STD_LOGIC;
           inst_SHL : in  STD_LOGIC;
           inst_ROR : in  STD_LOGIC;
           inst_ROL : in  STD_LOGIC;
           inst_HLT : in  STD_LOGIC;
			  flag_N : in STD_LOGIC;
			  flag_Z : in STD_LOGIC;
			  flag_V : in STD_LOGIC;
			  flag_B : in STD_LOGIC;
			  flag_C : in STD_LOGIC;
           carga_FLAG : out  STD_LOGIC;
           carga_RI : out  STD_LOGIC;
           sel_ULA : out  STD_LOGIC_VECTOR (3 downto 0);
           carga_RDM : out  STD_LOGIC;
           sel_MUX2 : out  STD_LOGIC;
           carga_ACC : out  STD_LOGIC;
           sel_MUX1 : out  STD_LOGIC;
           inc_PC : out  STD_LOGIC;
           carga_PC : out  STD_LOGIC;
           carga_REM : out  STD_LOGIC;
          -- read_mem : out  STD_LOGIC;
			  hlt : out STD_LOGIC;
           write_mem : out  STD_LOGIC);
end unidade_de_controle;

architecture Behavioral of unidade_de_controle is

type tipoestado is (S0, S1, S2, S3, S4 , S5, S6, S7);
signal estado, prox_estado : tipoestado;

constant ADD_inst : STD_LOGIC_VECTOR(3 downto 0) := "0000";
constant SUB_inst : STD_LOGIC_VECTOR(3 downto 0) := "0001";
constant OR_inst  : STD_LOGIC_VECTOR(3 downto 0) := "0010";
constant AND_inst : STD_LOGIC_VECTOR(3 downto 0) := "0011";
constant NOT_inst : STD_LOGIC_VECTOR(3 downto 0) := "0100";
constant SHL_inst : STD_LOGIC_VECTOR(3 downto 0) := "0101";
constant SHR_inst : STD_LOGIC_VECTOR(3 downto 0) := "0110";
constant ROR_inst : STD_LOGIC_VECTOR(3 downto 0) := "0111";
constant ROL_inst : STD_LOGIC_VECTOR(3 downto 0) := "1111";
constant Y_inst   : STD_LOGIC_VECTOR(3 downto 0) := "1001";


begin

process(clk, reset)
begin
	if reset = '1' then 
		estado <= s0;
	elsif rising_edge(clk) then
		estado <= prox_estado;
	else
		estado <= estado;
	end if;
end process;


process(estado, inst_NOP, inst_STA, inst_LDA, inst_ADD, inst_OR, inst_AND, 
inst_NOT, inst_SUB, inst_JMP, inst_JN, inst_JP, inst_JV, inst_JNV, inst_JZ, inst_JNZ, 
inst_JC, inst_JNC, inst_JB, inst_JNB, inst_SHR, inst_SHL, inst_ROR, inst_ROL, inst_HLT, 
flag_N, flag_Z, flag_B, flag_C, flag_V)
begin
	
	
	--declarar aqui
	prox_estado <= S0;
	hlt <= '0';
	carga_FLAG <= '0';
	carga_RI <= '0';
	sel_ULA <= "0000";
	carga_RDM <= '0';
	sel_MUX2 <= '0';
	carga_ACC <= '0';
	sel_MUX1 <= '0';
	inc_PC <= '0';
	carga_PC <= '0';
	carga_REM <= '0';
	--read_mem <= '0';
	write_mem <= '0';
	
	Case estado is
	
	when S0 =>
	
	sel_MUX1 <= '0';
	carga_REM <= '1';
	prox_estado <= S1;
	
	when S1 =>
	
	--read_mem <= '1';
	carga_RDM <= '1';
	sel_MUX2 <= '1';
	inc_PC <= '1';
	prox_estado <= S2;
	
	when S2 =>
	
	carga_RI <= '1';
	prox_estado <= S3;
	
	when S3 =>
	
	if (inst_NOT = '1') then
		sel_ULA <= NOT_inst;
		carga_ACC <= '1';
		carga_FLAG <= '1';
		prox_estado <= S0;	
	elsif (inst_JN = '1') then
		if flag_N = '0' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;	 
	elsif (inst_JZ = '1') then
		if flag_Z = '0' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;	 
	elsif (inst_NOP = '1') then
		prox_estado <= S0;           	
	elsif (inst_HLT = '1') then
		hlt <= '1';
		prox_estado <= S3; 		
	elsif (inst_SHR = '1') then
		sel_ULA <= SHR_inst;
		carga_ACC <= '1';
		carga_FLAG <= '1';
		prox_estado <= S0;	
	elsif (inst_SHL = '1') then
		sel_ULA <= SHL_inst;
		carga_ACC <= '1';
		carga_FLAG <= '1';
		prox_estado <= S0;		
	elsif (inst_ROR = '1') then
		sel_ULA <= ROR_inst;
		carga_ACC <= '1';
		carga_FLAG <= '1';
		prox_estado <= S0;	
	elsif (inst_ROL = '1') then
		sel_ULA <= ROL_inst;
		carga_ACC <= '1';
		carga_FLAG <= '1';
		prox_estado <= S0;		
	elsif (inst_JP = '1') then
		if flag_N = '1' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;	
	elsif (inst_JV = '1') then
		if flag_V = '0' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
			
	elsif (inst_JNV = '1') then
		if flag_V = '1' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
	
	elsif (inst_JC = '1') then
		if flag_C = '0' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '1'; ---
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
			
	elsif (inst_JNC = '1') then
		if flag_C = '1' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
			
	elsif (inst_JB = '1') then
		if flag_B = '0' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
		
	elsif (inst_JNB = '1') then
		if flag_B = '1' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
		
	elsif (inst_JNZ = '1') then
		if flag_Z = '1' then
			inc_PC <= '1';
			prox_estado <= S0;
		else
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S4;
		end if;
		
	else
		sel_MUX1 <= '0';
		carga_REM <= '1';
		prox_estado <= S4;
	end if;
	
	
	when S4 =>
	
		if (inst_STA = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		elsif (inst_LDA = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		elsif (inst_ADD = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		elsif (inst_OR = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		elsif (inst_AND = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		elsif (inst_SUB = '1') then
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			inc_PC <= '1';
			prox_estado <= S5;
		else
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			prox_estado <= S5;
		end if;
		
	when S5 =>
		if (inst_STA = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_LDA = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_ADD = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_OR = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_AND = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_SUB = '1') then
			sel_MUX1 <= '0';
			carga_REM <= '1';
			prox_estado <= S6;
		elsif (inst_JMP = '1') then
			carga_PC <= '1';
			prox_estado <= S0;
		else
			carga_PC <= '1';
			prox_estado <= S0;
		end if;
	
	
	when S6 =>
		if (inst_STA = '1') then
			carga_RDM <= '1';
			prox_estado <= S7;
		else
			--read_mem <= '1';
			carga_RDM <= '1';
			sel_MUX2 <= '1';
			prox_estado <= S7;
		end if;
	
	when S7 =>
		if (inst_STA = '1') then
			write_mem <= '1';
			prox_estado <= S0;
		elsif (inst_LDA = '1') then
			sel_ULA <= Y_inst;
			carga_ACC <= '1';
			carga_FLAG <= '1';
			prox_estado <= S0;
		elsif (inst_ADD = '1') then
			sel_ULA <= OR_inst;
			carga_ACC <= '1';
			carga_FLAG <= '1';
			prox_estado <= S0;
		elsif (inst_OR = '1') then
			sel_ULA <= ADD_inst;
			carga_ACC <= '1';
			carga_FLAG <= '1';
			prox_estado <= S0;
		elsif (inst_AND = '1') then
			sel_ULA <= AND_inst;
			carga_ACC <= '1';
			carga_FLAG <= '1';
			prox_estado <= S0;
		elsif (inst_SUB = '1') then
			sel_ULA <= SUB_inst;
			carga_ACC <= '1';
			carga_FLAG <= '1';
			prox_estado <= S0;
		else
			prox_estado <= S0;
		end if;
	
	when others =>
		prox_estado <= S0;
	end case;

end process;

end Behavioral;

