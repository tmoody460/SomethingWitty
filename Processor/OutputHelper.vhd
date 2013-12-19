library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY OutputHelper IS
	PORT(
		ramAddress: IN std_logic_vector(7 downto 0);
		toWrite: IN std_logic_vector(7 downto 0);
		sevenSegments: OUT std_logic_vector(7 downto 0);
		leftDecimal: OUT BIT;
		rightDecimal: OUT BIT
	);
END OutputHelper;


ARCHITECTURE behavior OF OutputHelper IS
	SIGNAL ssTemp: std_logic_vector(7 downto 0);
	SIGNAL ldTemp: BIT;
	SIGNAL rdTemp: BIT;
BEGIN
PROCESS(ramAddress, toWrite)
BEGIN
	IF (ramAddress(7)='0' AND ramAddress(6)='0' AND ramAddress(5)='0'  AND ramAddress(4)='0'  AND ramAddress(3)='0' AND ramAddress(2)='0' AND ramAddress(1)='0' AND ramAddress(0)='0') THEN
		ssTemp <= toWrite;
	ELSIF (ramAddress(7)='0' AND ramAddress(6)='0' AND ramAddress(5)='0'  AND ramAddress(4)='0'  AND ramAddress(3)='0' AND ramAddress(2)='0' AND ramAddress(1)='0' AND ramAddress(0)='1') THEN	
		ldTemp <= to_bit(toWrite(0));
	ELSIF (ramAddress(7)='0' AND ramAddress(6)='0' AND ramAddress(5)='0'  AND ramAddress(4)='0'  AND ramAddress(3)='0' AND ramAddress(2)='0' AND ramAddress(1)='1' AND ramAddress(0)='0') THEN	
		rdTemp <= to_bit(toWrite(0));
	END IF;
END PROCESS;
sevenSegments <= ssTemp;
leftDecimal <= ldTemp;
rightDecimal <= rdTemp;
END behavior;