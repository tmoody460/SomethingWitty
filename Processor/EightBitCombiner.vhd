library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY EightBitCombiner IS 
	PORT(
		input7: IN BIT;
		input6: IN BIT;
		input5: IN BIT;
		input4: IN BIT;
		input3: IN BIT;
		input2: IN BIT;
		input1: IN BIT;
		input0: IN BIT;
		output: OUT std_logic_vector(7 downto 0)
	);
END EightBitCombiner;

ARCHITECTURE behavior OF EightBitCombiner IS
BEGIN
	output(7) <= To_X01(input7);
	output(6) <= To_X01(input6);
	output(5) <= To_X01(input5);
	output(4) <= To_X01(input4);
	output(3) <= To_X01(input3);
	output(2) <= To_X01(input2);
	output(1) <= To_X01(input1);
	output(0) <= To_X01(input0);
END behavior;

