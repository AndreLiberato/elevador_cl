ENTITY state_machine IS PORT (
	bar_st_r_in	:	IN	BIT_VECTOR(3 DOWNTO 0);
	bar_st_c_in	:	IN	BIT_VECTOR(3 DOWNTO 0);
	clock		:	IN	BIT;
	enable_st_r	:	OUT	BIT;
	enable_st_c	:	OUT	BIT;
	control_st_c	:	OUT	BIT	);
END state_machine;

ARCHITECTURE arch OF state_machine IS
BEGIN
	PROCESS(clock, bar_st_r_in, bar_st_c_in)
	BEGIN
		IF (clock'EVENT AND clock='0') THEN
			IF (bar_st_r_in > bar_st_c_in) THEN
				enable_st_r <= '0';
				enable_st_c <= '1';
				control_st_c <= '1';
			ELSIF (bar_st_r_in < bar_st_c_in) THEN
				enable_st_r <= '0';
				enable_st_c <= '1';
				control_st_c <= '0';
			ELSE 
				enable_st_r <= '1';
				enable_st_c <= '0';
				control_st_c <= '1';
			END IF;
		END IF;
	END PROCESS;
END arch;