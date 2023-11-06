ENTITY recorder_target_floor IS PORT(
	bar_recorder_in		:	IN 	BIT_VECTOR(3 DOWNTO 0);
	clock			:	IN 	BIT;
	clear			:	IN 	BIT;
	enable			:	IN 	BIT;
	bar_recorder_out	:	OUT 	BIT_VECTOR(3 DOWNTO 0)	);
END recorder_target_floor;

ARCHITECTURE arch OF recorder_target_floor IS
BEGIN 
	PROCESS(clock, clear, bar_recorder_in) 
	BEGIN
		IF (clear = '0') THEN
			bar_recorder_out <= "0001";
		ELSIF (clock'EVENT AND clock = '1') THEN
			IF (enable = '1' AND bar_recorder_in /= "0000") THEN 
				bar_recorder_out <= bar_recorder_in;
			END IF;
		END IF;
	END PROCESS;
END arch;