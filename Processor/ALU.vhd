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
BEGIN
PROCESS(value1, value2, aluOp)
BEGIN
	IF (aluOp(2) = '0' AND aluOp(1) = '0' AND aluOp(0) = '0') THEN
		tempOutput <= value1 AND value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '0' AND aluOp(1) = '0' AND aluOp(0) = '1') THEN
		tempOutput <= value1 OR value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '0' AND aluOp(1) = '1' AND aluOp(0) = '0') THEN
		tempOutput <= value1 XOR value2;
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '0' AND aluOp(0) = '1') THEN
		tempOutput <= std_logic_vector(unsigned(value1) sll to_integer(unsigned(value2)));
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '0' AND aluOp(0) = '0') THEN
		tempOutput <= std_logic_vector(unsigned(value1) srl to_integer(unsigned(value2)));
		tempOverflow <= '0';
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '1') THEN
		tempOutput <= std_logic_vector(unsigned(value1) + unsigned(value2));
		
		IF ((value1(7) = '1' AND value2(7) = '1' AND tempOutput(7) = '0') OR (value1(7) = '0' AND value2(7) = '0' AND tempOutput(7) = '1')) THEN
			tempOverflow <= '1';
		ELSE
			tempOverflow <= '0';
		END IF;
		
	ELSIF (aluOp(2) = '1' AND aluOp(1) = '1' AND aluOp(0) = '0') THEN
		tempOutput <= std_logic_vector(unsigned(value1) - unsigned(value2));
		
		IF ((tempOutput(7) = '1' AND value2(7) = '1' AND value1(7) = '0') OR (tempOutput(7) = '0' AND value2(7) = '0' AND value1(7) = '1')) THEN
			tempOverflow <= '1';
		ELSE
			tempOverflow <= '0';
		END IF;
		
	END IF;
	
	IF (tempOutput(7)='0' AND tempOutput(6)='0' AND tempOutput(5)='0' AND tempOutput(4)='0' AND tempOutput(3)='0' AND tempOutput(2)='0' AND tempOutput(1)='0' AND tempOutput(0)='0') THEN
		tempZero <= '1';
	ELSE
		tempZero <= '0';
	END IF;
	
END PROCESS;

output <= tempOutput;
zero <= tempZero;
overflow <= tempOverflow;
sign <= to_bitvector(tempOutput)(7);
END behavior;



