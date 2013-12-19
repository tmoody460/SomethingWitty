library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Control IS
	PORT(
		opCode: IN std_logic_vector(3 downto 0);
		aluCode: IN std_logic_vector(2 downto 0);
		RegDst: OUT BIT;
		Branch: OUT BIT;
		MemRead: OUT BIT;
		MemToReg: OUT BIT;
		ALUOp: OUT std_logic_vector(2 downto 0);
		MemWrite: OUT BIT;
		ALUSrc: OUT BIT;
		RegWrite: OUT BIT
	);
END Control;

ARCHITECTURE behavior OF Control IS
		SIGNAL tempRegDst: BIT :='0';
		SIGNAL tempBranch: BIT :='0';
		SIGNAL tempMemRead: BIT :='0';
		SIGNAL tempMemToReg: BIT :='0';
		SIGNAL tempALUOp: std_logic_vector(2 downto 0);
		SIGNAL tempMemWrite: BIT :='0';
		SIGNAL tempALUSrc: BIT :='0';
		SIGNAL tempRegWrite: BIT :='0';
BEGIN
Process(opCode, ALUCode)
BEGIN
	IF (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '0') THEN
		tempRegDst <= '1';
	ELSIF (opCode(3) = '1' AND opCode(2) = '1' AND opCode(1) = '1') THEN
		tempRegDst <= '1';
	ELSE
		tempRegDst <= '0';
	END IF;
	IF (opCode(3) = '1' AND opCode(2) = '1' AND opCode(1) = '0') THEN
		tempBranch <= '1';
	ELSE
		tempBranch <='0';
	END IF;
	IF (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '1' AND opCode(0) = '0') THEN
		tempMemRead <= '1';
	ELSE
		tempMemRead <= '0';
	END IF;
	IF (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '1' AND opCode(0) = '0') THEN
		tempMemToReg <= '1';
	ELSE
		tempMemToReg <= '0';
	END IF;
	IF (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '1' AND opCode(0) = '1') THEN
		tempMemWrite <= '1';
	ELSE
		tempMemWrite <= '0';
	END IF;
	IF ((opCode(3) = '0' AND opCode(2) = '1') OR (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '1')) THEN
		tempALUSrc <= '1';
	ELSE
		tempALUSrc <= '0';
	END IF;
	IF ((opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '0') OR (opCode(3) = '0' AND opCode(2) = '1') OR (opCode(1) = '1' AND opCode(0) = '0')) THEN
		tempRegWrite <= '1';
	ELSE
		tempRegWrite <= '0';
	END IF;
	
	IF (opCode(3) = '1' AND opCode(2) = '1' AND opCode(1) = '0') THEN
		tempALUOp <= "110";
	ELSIF (opCode(3) = '0' AND opCode(2) = '0' AND opCode(1) = '1') THEN
		tempALUOp <= "111";
	ELSIF (opCode(3) = '0' AND opCode(2) = '1' AND opCode(0)='1') THEN
		tempALUOp <= "110";
	ELSIF (opCode(3) = '0' AND opCode(2) = '1' AND opCode(0)='0') THEN
		tempALUOp <= "111";
	ELSE
		tempALUOp <= ALUCode;
	END IF;
END PROCESS;

RegDst <= tempRegDst;
Branch <= tempBranch;
MemRead <= tempMemRead;
MemToReg <= tempMemToReg;
ALUOp <= tempALUOp;
MemWrite <= tempMemWrite;
ALUSrc <= tempALUSrc;
RegWrite <= tempRegWrite;

END behavior;