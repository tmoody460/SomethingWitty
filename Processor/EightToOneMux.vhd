library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
ENTITY EightToOneMux IS
	PORT(
		readRegId: IN std_logic_vector(2 downto 0);
		reg0: IN std_logic_vector(7 downto 0);
		reg1: IN std_logic_vector(7 downto 0);
		reg2: IN std_logic_vector(7 downto 0);
		reg3: IN std_logic_vector(7 downto 0);
		reg4: IN std_logic_vector(7 downto 0);
		reg5: IN std_logic_vector(7 downto 0);
		reg6: IN std_logic_vector(7 downto 0);
		reg7: IN std_logic_vector(7 downto 0);
		readReg: OUT std_logic_vector(7 downto 0)
	);
END EightToOneMux;

ARCHITECTURE behavior of EightToOneMux IS
	SIGNAL tempReadReg: std_logic_vector(7 downto 0);
BEGIN
PROCESS (readRegId)
BEGIN
IF (readRegId(2) = '0' AND readRegId(1) = '0' AND readRegId(0) = '0') THEN
	tempReadReg <= reg0;
ELSIF (readRegId(2) = '0' AND readRegId(1) = '0' AND readRegId(0) = '1') THEN
	tempReadReg <= reg1;
ELSIF (readRegId(2) = '0' AND readRegId(1) = '1' AND readRegId(0) = '0') THEN
	tempReadReg <= reg2;
ELSIF (readRegId(2) = '0' AND readRegId(1) = '1' AND readRegId(0) = '1') THEN
	tempReadReg <= reg3;
ELSIF (readRegId(2) = '1' AND readRegId(1) = '0' AND readRegId(0) = '0') THEN
	tempReadReg <= reg4;
ELSIF (readRegId(2) = '1' AND readRegId(1) = '0' AND readRegId(0) = '1') THEN
	tempReadReg <= reg5;
ELSIF (readRegId(2) = '1' AND readRegId(1) = '1' AND readRegId(0) = '0') THEN
	tempReadReg <= reg6;
ELSE
	tempReadReg <= reg7;
END IF;

END PROCESS;

readReg <= tempReadReg;
END behavior;
