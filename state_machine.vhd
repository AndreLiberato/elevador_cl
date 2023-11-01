ENTITY state_machine IS PORT (
	bar_recorder_tf		:	IN	BIT_VECTOR(3 DOWNTO 0);
	bar_counter_sf		:	IN	BIT_VECTOR(3 DOWNTO 0);
	clk			:	IN	BIT;
	enable_recorder_tf	:	OUT	BIT;
	enable_counter_sf	:	OUT	BIT;
	control_counter_sf	:	OUT	BIT
);
END state_machine;

ARCHITECTURE arch OF state_machine IS
BEGIN
	PROCESS(clk, bar_recorder_tf, bar_counter_sf)
	BEGIN
		IF (clk'EVENT AND clk='1') THEN
			IF (bar_recorder_tf > bar_counter_sf) THEN
				enable_recorder_tf <= '0';
				enable_counter_sf <= '1';
				control_counter_sf <= '1';
			ELSIF (bar_recorder_tf < bar_counter_sf) THEN
				enable_recorder_tf <= '0';
				enable_counter_sf <= '1';
				control_counter_sf <= '0';
			ELSE 
				enable_recorder_tf <= '1';
				enable_counter_sf <= '0';
				control_counter_sf <= '0';
			END IF;
		END IF;
	END PROCESS;
END arch;