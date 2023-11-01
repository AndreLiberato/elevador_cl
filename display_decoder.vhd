ENTITY display_decoder IS PORT (
	bar_counter_tf	:	IN	BIT_VECTOR(3 DOWNTO 0);
	bar_display	:	OUT	BIT_VECTOR(6 DOWNTO 0)
);
END display_decoder;

ARCHITECTURE arch OF display_decoder IS
BEGIN
	WITH bar_counter_tf SELECT 
		bar_display <= 
			"1001111" WHEN "0001",
			"0010010" WHEN "0010",
			"0000110" WHEN "0011",
			"1001100" WHEN "0100",
			"0100100" WHEN "0101",
			"0100000" WHEN "0110",
			"0001111" WHEN "0111",
			"0000000" WHEN "1000",
			"0000100" WHEN "1001",
			"1111111" WHEN OTHERS;
END arch;