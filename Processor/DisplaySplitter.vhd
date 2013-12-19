library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY DisplaySplitter IS
	PORT(
		toSevenSegments: IN std_logic_vector(7 downto 0);
		leftSegments: OUT std_logic_vector(3 downto 0);
		rightSegments: OUT std_logic_vector(3 downto 0)
	);
END DisplaySplitter;


ARCHITECTURE behavior OF DisplaySplitter IS
BEGIN
leftSegments <= toSevenSegments(7 downto 4);
rightSegments <= toSevenSegments(3 downto 0);
END behavior;

