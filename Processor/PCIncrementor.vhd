library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PCIncrementor IS
	PORT(
		inPC: IN std_logic_vector(7 downto 0);
		outPC: OUT std_logic_vector(7 downto 0)
	);
END PCIncrementor;

ARCHITECTURE behavior OF PCIncrementor IS
	SIGNAL tempPC: std_logic_vector(7 downto 0);
BEGIN
PROCESS (inPC)
BEGIN
	tempPC <= std_logic_vector(unsigned(inPC) + 1);
END PROCESS;

outPC <= tempPC;

END behavior;