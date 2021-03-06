library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ALU IS 
	PORT(
		value1: IN std_logic_vector(7 downto 0);
		value2: IN std_logic_vector(7 downto 0);
		aluOp: IN std_logic_vector(2 downto 0);
		output: OUT std_logic_vector(7 downto 0);
		zero: OUT BIT;
		overflow: OUT BIT;
		sign: OUT BIT
	);
END ALU;


ARCHITECTURE behavior OF ALU IS
	SIGNAL tempOutput: std_logic_vector(7 downto 0);
	SIGNAL tempZero: BIT;
	SIGNAL tempOverflow: BIT;
	SIGNAL tempSign: BIT;
BEGIN
PROCESS(value1, value2, aluOp)
	VARIABLE varOutput: std_logic_vector(7 downto 0);
	
BEGIN
	IF (aluOp(2) = '0' AND aluOp(1) = '0' AND aluOp(0) = '0') THEN
		varOutput := value1 AND value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '0' AND aluOp(1) = '0' AND aluOp(0) = '1') THEN
		varOutput := value1 OR value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '0' AND aluOp(1) = '1' AND aluOp(0) = '0') THEN
		varOutput := value1 XOR value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '0' AND aluOp(0) = '1') THEN
		varOutput := std_logic_vector(unsigned(value1) sll to_integer(unsigned(value2)));
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '0' AND aluOp(0) = '0') THEN
		varOutput := std_logic_vector(unsigned(value1) srl to_integer(unsigned(value2)));
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '1') THEN
		varOutput := std_logic_vector(unsigned(value1) + unsigned(value2));
	
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '0') THEN
		varOutput := std_logic_vector(unsigned(value1) - unsigned(value2));
		
	ELSE
		--no commands match
	END IF;
	
	IF (varOutput(7)='0' AND varOutput(6)='0' AND varOutput(5)='0' AND varOutput(4)='0' AND varOutput(3)='0' AND varOutput(2)='0' AND varOutput(1)='0' AND varOutput(0)='0') THEN
		tempZero <= '1';
	ELSE
		tempZero <= '0';
	END IF;
	
	IF ((aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '1') 
		AND ((value1(7) = '1' AND value2(7) = '1' AND varOutput(7) = '0') 
			OR (value1(7) = '0' AND value2(7) = '0' AND varOutput(7) = '1'))) THEN
		tempOverflow <= '1';
	ELSIF ((aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '0') 
		AND ((varOutput(7) = '1' AND value2(7) = '1' AND value1(7) = '0') 
			OR (varOutput(7) = '0' AND value2(7) = '0' AND value1(7) = '1'))) THEN
		tempOverflow <= '1';
	ELSE
		tempOverflow <= '0';
	END IF;
	
	tempSign <= to_bitvector(varOutput)(7);
	tempOutput <= varOutput;
END PROCESS;

output <= tempOutput;
zero <= tempZero;
overflow <= tempOverflow;
sign <= tempSign;
END behavior;



