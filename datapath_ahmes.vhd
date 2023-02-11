----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:09:58 01/25/2023 
-- Design Name: 
-- Module Name:    datapath_ahmes - Behavioral 
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

entity datapath_ahmes is
    Port ( clk : in  STD_LOGIC;
           carga_acc : in  STD_LOGIC;
           inc_pc : in  STD_LOGIC;
           carga_pc : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           carga_rem : in  STD_LOGIC;
           sel_mux : in  STD_LOGIC;
           carga_rdm : in  STD_LOGIC;
           sel_mux2 : in  STD_LOGIC;
           carga_ri : in  STD_LOGIC;
           sel_ula : in  STD_LOGIC_VECTOR (3 downto 0);
           carga_flag : in  STD_LOGIC;
           endereco : out  STD_LOGIC_VECTOR (7 downto 0);
           dado_entrada : out  STD_LOGIC_VECTOR (7 downto 0);
           dado_saida : in  STD_LOGIC_VECTOR (7 downto 0);
			  reg_ri : out STD_LOGIC_VECTOR(7 downto 0);
			  flag_ula_control : out STD_LOGIC_VECTOR(4 downto 0));
			  
end datapath_ahmes;

architecture Behavioral of datapath_ahmes is

--Saida ULA é entrada do acumulador
signal ula_output : std_logic_vector(7 downto 0);

--Saida do acumulador é entrada da ULA e do MUX2
signal acc_output : std_logic_vector(7 downto 0);

--saida do MUX2 e entrada do RDM
signal mux2_output : std_logic_vector(7 downto 0);

--saida do MUX e entrada do RDM
signal mux_output : std_logic_vector(7 downto 0);

--saida do RDM e entrada do MUX, PC, ULA e RI
signal rdm_output : std_logic_vector(7 downto 0);

--saida do RI e entrada do UC que é o reg_ri
signal ri_output : std_logic_vector(7 downto 0);

--saida do PC e entrada do MUX
signal pc_output : std_logic_vector(7 downto 0);

--saida do rem depois passa para end
signal rem_output : std_logic_vector(7 downto 0);

--saida ULA controle flag
signal flag_output : std_logic_vector(4 downto 0);

--saida registrador flag
signal regflag_output : std_logic_vector(4 downto 0);

--signal ula operating
--signal ula_operation : std_logic_vector(8 downto 0);

begin

reg_acumulador: process(clk, reset)
begin
	if reset = '1' then 
		acc_output <= "00000000";
	elsif clk'event and clk='1' then
		if carga_acc = '1' then
			acc_output <= ula_output;
		else
			acc_output <= acc_output;
		end if;
	end if;
end process;

reg_pc: process(clk, reset)
begin
	if reset='1' then
		pc_output <= "00000000";
	elsif clk'event and clk='1' then
		if carga_pc = '1' then
			pc_output <= rdm_output;
		elsif inc_pc = '1' then
			pc_output <= std_logic_vector(unsigned(pc_output) + 1);
		else
			pc_output <= pc_output;
		end if;
	end if;	
end process;

reg_instrucao: process(clk, reset)
begin
	if reset='1' then
		ri_output <= "00000000";
	elsif clk'event and clk='1' then
		if carga_ri = '1' then
			ri_output <= rdm_output;
		else
			ri_output <= ri_output;
		end if;
	end if;
end process;
reg_ri <= ri_output;

--mux_1: process(sel_mux, rdm_output, pc_output)
--begin
	--case sel_mux is
	--when '0' => mux_output <= pc_output;
	--when others => mux_output <= rdm_output;
	--end case;	
--end process;

--mux_1:
mux_output <= pc_output when sel_mux = '0' else
				rdm_output;


reg_rem: process(clk, reset)
begin
	if reset='1' then
		rem_output <= "00000000";
	elsif clk'event and clk='1' then
		if carga_rem = '1' then
			rem_output <= mux_output;
		else
			rem_output <= rem_output;
		end if;
	end if;	
end process;
endereco <= rem_output;

--mux_2: process(sel_mux2, acc_output, dado_saida)
--begin
--	case sel_mux2 is
--	when '0' => mux2_output <= acc_output;
--	when others => mux2_output <= dado_saida;
--	end case;	
--end process;

--mux_2
mux2_output <= acc_output when sel_mux2 = '0' else
				dado_saida; 

reg_rdm: process(clk, reset)
begin
	if reset='1' then
		rdm_output <= "00000000";
	elsif clk'event and clk='1' then
		if carga_rdm = '1' then
			rdm_output <= mux2_output;
		else
			rdm_output <= rdm_output;
		end if;
	end if;	
end process;
dado_entrada <= rdm_output;

ula_imp : process(rdm_output, acc_output, sel_ula, flag_output, ula_output)
variable ula_operation : std_logic_vector(8 downto 0);
variable ula_output_var : std_logic_vector(7 downto 0);
begin
	case sel_ula is
	
		when "0000" => 
			ula_operation := std_logic_vector(signed('0'&acc_output) + signed('0'&rdm_output));
         ula_output_var := ula_operation(7 downto 0);
         flag_output(4) <= ula_operation(8);
			flag_output(2) <= ula_operation(7) xor ula_operation(8);
			flag_output(3) <= '0';
			
		when "0001" => 
			ula_operation := std_logic_vector(signed('0'&acc_output) - signed('0'&rdm_output));
			ula_output_var := ula_operation(7 downto 0);
			flag_output(2) <= ula_operation(8);
 			flag_output(3) <= (ula_operation(7) xnor ula_operation(8));
			flag_output(4) <= '0';
			
		when "0010" => 
			ula_output_var := (rdm_output OR acc_output);
			flag_output(3) <= '0';
			flag_output(4) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
		
		when "0011" => 
			ula_output_var := (rdm_output AND acc_output);
			flag_output(3) <= '0';
			flag_output(4) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
		
		when "0100" => 
			ula_output_var := (NOT acc_output);
			flag_output(3) <= '0';
			flag_output(4) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
		
		when "0101" => 
			ula_output_var(7 downto 1) := acc_output(6 downto 0); --SHL
			ula_output_var(0) := '0';
			flag_output(4) <= acc_output(7);
			flag_output(3) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
			
		when "0110" => 
			ula_output_var(6 downto 0) := acc_output(7 downto 1);
			ula_output_var(7) := '0'; --SHR
			flag_output(4) <= acc_output(0);
			flag_output(3) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
			
		when "0111" => 
			--ROR
			ula_output_var(7) := acc_output(0);
			ula_output_var(6 downto 0) := acc_output(7 downto 1);
			flag_output(4) <= acc_output(0);
			flag_output(3) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
			
		when "1001" =>
			--y
			ula_output_var := rdm_output;
			flag_output(4) <= '0';
			flag_output(3) <= '0';
			flag_output(2) <= '0';
			ula_operation := "000000000";
			
		when "1111" =>
			 -- ROL
			ula_operation(0) := acc_output(7);
			ula_operation(7 downto 1) := acc_output(6 downto 0);
			ula_output_var := ula_operation(7 downto 0);
			flag_output(4) <= acc_output(7);
			flag_output(3) <= '0';
			flag_output(2) <= '0';
			ula_operation(8) := '0';
			
		when others => 
			ula_operation := "000000000";
			ula_output_var := "00000000";
			flag_output <= "00000";
			
		end case;


		if (ula_output(7) = '1') then
				flag_output(1) <= '1'; --flag do negativo
		else
				flag_output(1) <= '0';
		end if; 
		if (ula_output = "00000000") then
			flag_output(0) <= '1'; --flag do zero
		else
			flag_output(0) <= '0';
		end if;
		
		ula_output <= ula_output_var;
end process;

reg_flag: process(clk)
begin
	if clk'event and clk='1' then
		if carga_flag = '1' then
			regflag_output <= flag_output;
		else
			regflag_output <= regflag_output;
		end if;
	else
		regflag_output <= regflag_output;
	end if;
end process;
flag_ula_control <= regflag_output;



end Behavioral;

