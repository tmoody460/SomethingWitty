library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
        
ENTITY Decoder IS
     PORT ( 
		instruction: IN std_logic_vector(15 downto 0);
		opCode:		 OUT std_logic_vector(3 downto 0);	
		reg1:		 OUT std_logic_vector(2 downto 0);	
		reg2:		 OUT std_logic_vector(2 downto 0);	
		reg3:		 OUT std_logic_vector(2 downto 0);
		aluCode:	 OUT std_logic_vector(2 downto 0);
		imm6:		 OUT std_logic_vector(5 downto 0);	
		imm9:		 OUT std_logic_vector(8 downto 0)	
        );
END Decoder;

ARCHITECTURE behaviour OF Decoder IS
BEGIN
		opCode <= instruction(15 downto 12);
		reg1 <= instruction(11 downto 9);
		reg2 <= instruction(8 downto 6);
		reg3 <= instruction(5 downto 3);
		aluCode <= instruction(2 downto 0);
		imm6 <= instruction(5 downto 0);
		imm9 <= instruction(8 downto 0);
END behaviour;