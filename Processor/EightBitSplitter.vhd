library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY EightBitSplitter IS
	PORT (
		input: IN std_logic_vector(7 downto 0);
		out7: OUT BIT;
		out6: OUT BIT;
		out5: OUT BIT;
		out4: OUT BIT;
		out3: OUT BIT;
		out2: OUT BIT;
		out1: OUT BIT;
		out0: OUT BIT
	);
END EightBitSplitter;

ARCHITECTURE behavior OF EightBitSplitter IS

BEGIN
out7 <= to_bitvector(input)(7);
out6 <= to_bitvector(input)(6);
out5 <= to_bitvector(input)(5);
out4 <= to_bitvector(input)(4);
out3 <= to_bitvector(input)(3);
out2 <= to_bitvector(input)(2);
out1 <= to_bitvector(input)(1);
out0 <= to_bitvector(input)(0);
END behavior;