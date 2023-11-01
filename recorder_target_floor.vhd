ENTITY recorder_target_floor IS PORT(
	bar_kb	:	IN 	BIT_VECTOR(3 DOWNTO 0);
	clk	:	IN 	BIT;
	clr	:	IN 	BIT;
	enbl	:	IN 	BIT;
	bar_out	:	OUT 	BIT_VECTOR(3 DOWNTO 0));
END recorder_target_floor; 

ARCHITECTURE arch OF recorder_target_floor IS 
BEGIN 
	PROCESS(clk, clr) 
	BEGIN 
		IF (clr = '0') THEN 
			bar_out <= "0001"; 
		ELSIF (clk'EVENT AND clk = '1') THEN 
			IF (enbl = '1') THEN 
				bar_out <= bar_kb;
			END IF;
		END IF;
	END PROCESS;
END arch;