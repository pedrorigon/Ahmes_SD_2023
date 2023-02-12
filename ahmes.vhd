----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:13 02/07/2023 
-- Design Name: 
-- Module Name:    ahmes - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ahmes is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  flags : out STD_LOGIC_VECTOR (4 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
			  hlt : out STD_LOGIC);
end ahmes;

architecture Behavioral of ahmes is

COMPONENT memoria
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;


component datapath_ahmes
    Port ( clk : in  STD_LOGIC;
           carga_acc : in  STD_LOGIC;
           inc_pc : in  STD_LOGIC;
           carga_pc : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           carga_rem : in  STD_LOGIC;
           sel_mux : in  STD_LOGIC;
           sel_mux2 : in  STD_LOGIC;
           carga_ri : in  STD_LOGIC;
           sel_ula : in  STD_LOGIC_VECTOR (3 downto 0);
           carga_flag : in  STD_LOGIC;
           endereco : out  STD_LOGIC_VECTOR (7 downto 0);
           dado_entrada : out  STD_LOGIC_VECTOR (7 downto 0);
           dado_saida : in  STD_LOGIC_VECTOR (7 downto 0);
			  reg_ri : out STD_LOGIC_VECTOR(7 downto 0);
			  flag_ula_control : out STD_LOGIC_VECTOR(4 downto 0));		  
end component;

component unidade_de_controle
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
           sel_MUX2 : out  STD_LOGIC;
           carga_ACC : out  STD_LOGIC;
           sel_MUX1 : out  STD_LOGIC;
           inc_PC : out  STD_LOGIC;
           carga_PC : out  STD_LOGIC;
           carga_REM : out  STD_LOGIC;
			  hlt : out STD_LOGIC;
           write_mem : out  STD_LOGIC);
end component;

component decodificador_inst
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
end component;


--signals
signal carga_PC : std_logic;
signal carga_REM : std_logic;
--signal carga_RDM : std_logic;
signal carga_ACC : std_logic;
signal carga_FLAG : std_logic;
signal carga_RI : std_logic;

signal inst_NOP : STD_LOGIC;
signal inst_STA : STD_LOGIC;
signal inst_LDA : STD_LOGIC;
signal inst_ADD : STD_LOGIC;
signal inst_OR : STD_LOGIC;
signal inst_AND : STD_LOGIC;
signal inst_NOT : STD_LOGIC;
signal inst_SUB : STD_LOGIC;
signal inst_JMP : STD_LOGIC;
signal inst_JN : STD_LOGIC;
signal inst_JP : STD_LOGIC;
signal inst_JV : STD_LOGIC;
signal inst_JNV : STD_LOGIC;
signal inst_JZ : STD_LOGIC;
signal inst_JNZ : STD_LOGIC;
signal inst_JC : STD_LOGIC;
signal inst_JNC : STD_LOGIC;
signal inst_JB : STD_LOGIC;
signal inst_JNB : STD_LOGIC;
signal inst_SHR : STD_LOGIC;
signal inst_SHL : STD_LOGIC;
signal inst_ROR : STD_LOGIC;
signal inst_ROL : STD_LOGIC;
signal inst_HLT : STD_LOGIC;

signal inc_PC : std_logic;
signal sel_mux : std_logic;
signal sel_mux2 : std_logic;
signal sel_ULA : std_logic_vector (3 downto 0);


signal input_MUX2 : STD_LOGIC_VECTOR (7 downto 0);  --vai endereco ou é da memória  
signal dado_entrada : STD_LOGIC_VECTOR (7 downto 0); --vai endereco ou é da memória
signal output_RI : STD_LOGIC_VECTOR(7 downto 0);
signal output_REM : STD_LOGIC_VECTOR (7 downto 0); --vai endereco ou é da memória
signal flag_ula_control : STD_LOGIC_VECTOR(4 downto 0);

signal iWrite : std_logic_vector (0 downto 0);

begin


datapapath: datapath_ahmes 
    port map ( clk => clk,
           carga_acc => carga_ACC,
           inc_pc => inc_PC,
           carga_pc => carga_PC,
           reset => reset,
           carga_rem => carga_REM,
           sel_mux => sel_mux,
           sel_mux2 => sel_mux2,
           carga_ri => carga_RI,
           sel_ula => sel_ULA,
           carga_flag => carga_FLAG,
           endereco => output_REM,
           dado_entrada => dado_entrada,
           dado_saida => input_MUX2,
			  reg_ri => output_RI,
			  flag_ula_control => flag_ula_control);		  

decod_RI: decodificador_inst
	port map (saida_RI => output_RI,
			inst_NOP => inst_NOP,
			inst_STA => inst_STA,
			inst_LDA => inst_LDA,
			inst_ADD => inst_ADD,
			inst_OR => inst_OR,
			inst_AND => inst_AND,
			inst_NOT => inst_NOT,
			inst_SUB => inst_SUB,
			inst_JMP => inst_JMP,
			inst_JN => inst_JN,
			inst_JP => inst_JP,
			inst_JV => inst_JV,
			inst_JNV => inst_JNV,
			inst_JZ => inst_JZ,
			inst_JNZ => inst_JNZ,
			inst_JC => inst_JC,
			inst_JNC => inst_JNC,
			inst_JB => inst_JB,
			inst_JNB => inst_JNB,
			inst_SHR => inst_SHR,
			inst_SHL => inst_SHL,
			inst_ROR => inst_ROR,
			inst_ROL => inst_ROL,
			inst_HLT => inst_HLT);

control_unity: unidade_de_controle
    port map ( clk => clk,
			  reset => reset,
			  inst_NOP => inst_NOP,
           inst_STA => inst_STA,
           inst_LDA => inst_LDA,
           inst_ADD => inst_ADD,
           inst_OR => inst_OR,
           inst_AND => inst_AND,
           inst_NOT => inst_NOT,
           inst_SUB => inst_SUB,
           inst_JMP => inst_JMP,
           inst_JN => inst_JN,
           inst_JP => inst_JP,
           inst_JV => inst_JV,
           inst_JNV => inst_JNV,
           inst_JZ => inst_JZ,
           inst_JNZ => inst_JNZ,
           inst_JC => inst_JC,
           inst_JNC => inst_JNC,
           inst_JB => inst_JB,
           inst_JNB => inst_JNB,
           inst_SHR => inst_SHR,
           inst_SHL => inst_SHL,
           inst_ROR => inst_ROR,
           inst_ROL => inst_ROL,
           inst_HLT => inst_HLT,
			  flag_N => flag_ula_control(1), -- flag_ula_control (1) negativo
			  flag_Z => flag_ula_control(0),-- flag_ula_control (0) zero
			  flag_V => flag_ula_control(2), -- flag_ula_control (2) overflow
			  flag_B => flag_ula_control(3), -- flag_ula_control (3) borrow
			  flag_C => flag_ula_control(4), -- flag_ula_control (4) carry
           carga_FLAG => carga_FLAG,
           carga_RI => carga_RI,
           sel_ULA => sel_ULA,

           sel_MUX2 => sel_mux2,
           carga_ACC => carga_ACC,
           sel_MUX1 => sel_mux,
           inc_PC => inc_PC,
           carga_PC => carga_PC,
           carga_REM => carga_REM,
			  hlt => hlt,
           write_mem => iWrite(0));--? 

memory_ahmes : memoria
  PORT MAP (
    clka => clk,
    wea => iWrite,
    addra => output_REM,
    dina => dado_entrada,
    douta => input_MUX2
  );


flags <= flag_ula_control;
dout <= dado_entrada;

end Behavioral;

