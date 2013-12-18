library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY DeMux IS
	PORT (
		writeRegId: IN std_logic_vector(2 downto 0);
		writeEnabled: IN BIT;
		reg0: OUT BIT;
		reg1: OUT BIT;
		reg2: OUT BIT;
		reg3: OUT BIT;
		reg4: OUT BIT;
		reg5: OUT BIT;
		reg6: OUT BIT;
		reg7: OUT BIT
	);
END DeMux;

ARCHITECTURE behavior OF DeMux IS 
	SIGNAL tempReg1: BIT;
	SIGNAL tempReg2: BIT;
	SIGNAL tempReg3: BIT;
	SIGNAL tempReg4: BIT;
	SIGNAL tempReg5: BIT;
	SIGNAL tempReg6: BIT;
	SIGNAL tempReg7: BIT;
BEGIN
PROCESS (writeRegId, writeEnabled)
BEGIN
IF (writeRegId(2) = '0' AND writeRegId(1) = '0' AND writeRegId(0) = '1' AND writeEnabled = '1') THEN
	tempReg1 <= '1';
ELSE
	tempReg1 <= '0';
END IF;
IF (writeRegId(2) = '0' AND writeRegId(1) = '1' AND writeRegId(0) = '0' AND writeEnabled = '1') THEN
	tempReg2 <= '1';
ELSE
	tempReg2 <= '0';
END IF;
IF (writeRegId(2) = '0' AND writeRegId(1) = '1' AND writeRegId(0) = '1' AND writeEnabled = '1') THEN
	tempReg3 <= '1';
ELSE
	tempReg3 <= '0';
END IF;
IF (writeRegId(2) = '1' AND writeRegId(1) = '0' AND writeRegId(0) = '0' AND writeEnabled = '1') THEN
	tempReg4 <= '1';
ELSE
	tempReg4 <= '0';
END IF;
IF (writeRegId(2) = '1' AND writeRegId(1) = '0' AND writeRegId(0) = '1' AND writeEnabled = '1') THEN
	tempReg5 <= '1';
ELSE
	tempReg5 <= '0';
END IF;
IF (writeRegId(2) = '1' AND writeRegId(1) = '1' AND writeRegId(0) = '0' AND writeEnabled = '1') THEN
	tempReg6 <= '1';
ELSE
	tempReg6 <= '0';
END IF;
IF (writeRegId(2) = '1' AND writeRegId(1) = '1' AND writeRegId(0) = '1' AND writeEnabled = '1') THEN
	tempReg7 <= '1';
ELSE
	tempReg7 <= '0';
END IF;

END PROCESS;
reg0 <= '0';
reg1 <= tempReg1;
reg2 <= tempReg2;
reg3 <= tempReg3;
reg4 <= tempReg4;
reg5 <= tempReg5;
reg6 <= tempReg6;
reg7 <= tempReg7;
END behavior;
