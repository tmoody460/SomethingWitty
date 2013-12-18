library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SignExtender IS
	PORT(
		shorter: IN std_logic_vector(5 downto 0);
		longer: OUT std_logic_vector(7 downto 0)
	);
END SignExtender;

ARCHITECTURE behavior OF SignExtender IS
BEGIN
longer <= shorter(5) & shorter(5) & shorter;
END behavior;