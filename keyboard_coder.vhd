ENTITY keyboard_coder IS PORT (
	bar_coder_in	:	IN	BIT_VECTOR(8 DOWNTO 0);
	bar_coder_out	:	OUT	BIT_VECTOR(3 DOWNTO 0)	);
END keyboard_coder;

ARCHITECTURE arch OF keyboard_coder IS
BEGIN
	WITH bar_coder_in SELECT 
		bar_coder_out <= 
			"0001" WHEN "000000001",
			"0010" WHEN "000000010",
			"0011" WHEN "000000100",
			"0100" WHEN "000001000",
			"0101" WHEN "000010000",
			"0110" WHEN "000100000",
			"0111" WHEN "001000000",
			"1000" WHEN "010000000",
			"1001" WHEN "100000000",
			"0000" WHEN OTHERS;
END arch;