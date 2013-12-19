library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY JRDetector IS
	PORT(
		opCode: IN std_logic_vector(3 downto 0);
		isJR: OUT BIT
	);
END JRDetector;

ARCHITECTURE behavior OF JRDetector IS
	SIGNAL tempIsJR: BIT;
BEGIN
PROCESS(opCode)
BEGIN
	IF (opCode(3)='1' AND opCode(2)='0' AND opCode(1)='0' AND opCode(0)='0') THEN
		tempIsJR <= '1';
	ELSE
		tempIsJR <= '0';
	END IF;
END PROCESS;
isJR <= tempIsJR;
END behavior;
