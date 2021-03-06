library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
ENTITY SevenSegmenter IS
	PORT(
		toDisplay: IN std_logic_vector(3 downto 0);
		segA: OUT BIT;
		segB: OUT BIT;
		segC: OUT BIT;
		segD: OUT BIT;
		segE: OUT BIT;
		segF: OUT BIT;
		segG: OUT BIT
	);
END SevenSegmenter;


ARCHITECTURE behavior OF SevenSegmenter IS
	SIGNAL tempA: BIT;
	SIGNAL tempB: BIT;
	SIGNAL tempC: BIT;
	SIGNAL tempD: BIT;
	SIGNAL tempE: BIT;
	SIGNAL tempF: BIT;
	SIGNAL tempG: BIT;
BEGIN
PROCESS(toDisplay)
BEGIN
	IF(toDisplay(3)='0' AND toDisplay(2)='0' AND toDisplay(1)='0' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '0';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='0' AND toDisplay(1)='0' AND toDisplay(0)='1') THEN
		tempA <= '0';
		tempB <= '1';
		tempC <= '1';
		tempD <= '0';
		tempE <= '0';
		tempF <= '0';
		tempG <= '0';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='0' AND toDisplay(1)='1' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '0';
		tempD <= '1';
		tempE <= '1';
		tempF <= '0';
		tempG <= '1';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='0' AND toDisplay(1)='1' AND toDisplay(0)='1') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '1';
		tempE <= '0';
		tempF <= '0';
		tempG <= '1';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='1' AND toDisplay(1)='0' AND toDisplay(0)='0') THEN
		tempA <= '0';
		tempB <= '1';
		tempC <= '1';
		tempD <= '0';
		tempE <= '0';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='1' AND toDisplay(1)='0' AND toDisplay(0)='1') THEN
		tempA <= '1';
		tempB <= '0';
		tempC <= '1';
		tempD <= '1';
		tempE <= '0';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='1' AND toDisplay(1)='1' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '0';
		tempC <= '1';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='0' AND toDisplay(2)='1' AND toDisplay(1)='1' AND toDisplay(0)='1') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '0';
		tempE <= '0';
		tempF <= '0';
		tempG <= '0';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='0' AND toDisplay(1)='0' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='0' AND toDisplay(1)='0' AND toDisplay(0)='1') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '0';
		tempE <= '0';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='0' AND toDisplay(1)='1' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '1';
		tempC <= '1';
		tempD <= '0';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='0' AND toDisplay(1)='1' AND toDisplay(0)='1') THEN
		tempA <= '0';
		tempB <= '0';
		tempC <= '1';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='1' AND toDisplay(1)='0' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '0';
		tempC <= '0';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '0';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='1' AND toDisplay(1)='0' AND toDisplay(0)='1') THEN
		tempA <= '0';
		tempB <= '1';
		tempC <= '1';
		tempD <= '1';
		tempE <= '1';
		tempF <= '0';
		tempG <= '1';
	ELSIF(toDisplay(3)='1' AND toDisplay(2)='1' AND toDisplay(1)='1' AND toDisplay(0)='0') THEN
		tempA <= '1';
		tempB <= '0';
		tempC <= '0';
		tempD <= '1';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	ELSE
		tempA <= '1';
		tempB <= '0';
		tempC <= '0';
		tempD <= '0';
		tempE <= '1';
		tempF <= '1';
		tempG <= '1';
	END IF;
END PROCESS;
segA <= tempA;
segB <= tempB;
segC <= tempC;
segD <= tempD;
segE <= tempE;
segF <= tempF;
segG <= tempG;
END behavior;
