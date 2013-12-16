ENTITY ClockSplitter IS
	PORT(
		clk : IN BIT;
		reset: IN BIT;
		clk1: OUT BIT;
		clk2: OUT BIT
	);
END ClockSplitter;

ARCHITECTURE behavioral OF ClockSplitter IS
	SIGNAL clk1Temp: BIT :='1';
	SIGNAL clk2Temp: BIT :='0';
BEGIN
PROCESS(clk, reset)
BEGIN
	IF(reset = '1') THEN
		clk1Temp <= '0';
		clk2Temp <= '0';
	ELSIF(clk'EVENT AND clk = '1') THEN
		clk1Temp <= NOT clk1Temp;
		clk2Temp <= NOT clk2Temp;
	END IF;
END PROCESS;

clk1<= clk1Temp;
clk2<= clk2Temp;
	
END behavioral;