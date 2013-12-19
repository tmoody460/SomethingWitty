library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY JumpDetector IS
	PORT(
		opCode: IN std_logic_vector(3 downto 0);
		zeroFlag: IN BIT;
		jumpDetected: OUT BIT
	);
END JumpDetector;

ARCHITECTURE behavior OF JumpDetector IS
	SIGNAL tempJump: BIT;
BEGIN
PROCESS(opCode, zeroFlag)
BEGIN
	IF(opCode(3)='1' AND opCode(2)='0') THEN
		tempJump<='1';
	ELSIF(opCode(3)='1' AND opCode(2)='1' AND opCode(1)='0' AND opCode(0)='1' AND zeroFlag='0') THEN
		tempJump<='1';
	ELSIF(opCode(3)='1' AND opCode(2)='1' AND opCode(1)='0' AND opCode(0)='0' AND zeroFlag='1') THEN
		tempJump<='1';
	ELSE
		tempJump<='0';
	END IF;
	
END PROCESS;
jumpDetected <= tempJump;
END behavior;
