ENTITY main IS PORT (
	bar_kb_coder_in		:	IN	BIT_VECTOR(8 DOWNTO 0);
	clock			:	IN	BIT;
	clear			:	IN	BIT;
	bar_dp_decoder_out	:	OUT	BIT_VECTOR(6 DOWNTO 0)	);
END main;

ARCHITECTURE arch OF main IS
	
	-- Codificador do teclado
	COMPONENT keyboard_coder IS PORT (
		bar_coder_in	:	IN	BIT_VECTOR(8 DOWNTO 0);
		bar_coder_out	:	OUT	BIT_VECTOR(3 DOWNTO 0)	);
	END COMPONENT keyboard_coder;

	-- Registrador do andar alvo
	COMPONENT recorder_target_floor IS PORT(
		bar_recorder_in		:	IN 	BIT_VECTOR(3 DOWNTO 0);
		clock			:	IN 	BIT;
		clear			:	IN 	BIT;
		enable			:	IN 	BIT;
		bar_recorder_out	:	OUT 	BIT_VECTOR(3 DOWNTO 0)	);
	END COMPONENT recorder_target_floor;
	
	-- Máquina de estados
	COMPONENT state_machine IS PORT (
		bar_st_r_in		:	IN	BIT_VECTOR(3 DOWNTO 0);
		bar_st_c_in		:	IN	BIT_VECTOR(3 DOWNTO 0);
		clock			:	IN	BIT;
		enable_st_r		:	OUT	BIT;
		enable_st_c		:	OUT	BIT;
		control_st_c		:	OUT	BIT	);
	END COMPONENT state_machine;

	-- Contador do andar atual
	COMPONENT counter_source_floor IS PORT(
		clock		:	IN	BIT;
		clear		:	IN	BIT;
		enable		:	IN	BIT;
		control		:	IN	BIT;
		bar_counter_out	:	OUT	BIT_VECTOR(3 DOWNTO 0)	);
	END COMPONENT counter_source_floor;

	-- Decodificador do display
	COMPONENT display_decoder IS PORT (
		bar_decoder_in	:	IN	BIT_VECTOR(3 DOWNTO 0);
		bar_decoder_out	:	OUT	BIT_VECTOR(6 DOWNTO 0)	);
	END COMPONENT display_decoder;
	
	signal bar_a	:	BIT_VECTOR(3 DOWNTO 0); -- Coder to Recorder
	signal bar_b	: 	BIT_VECTOR(3 DOWNTO 0); -- Recorder to State Machine
	signal bar_c	:	BIT_VECTOR(3 DOWNTO 0);	-- Counter to State Machine & Display Decoder
	signal enable_r	:	BIT; -- State Machine to Recorder
	signal enable_c	:	BIT; -- State Machine to Counter
	signal control_c:	BIT; -- State Machine to Counter

BEGIN
	l1	:	keyboard_coder PORT MAP (
				bar_coder_in => bar_kb_coder_in,
				bar_coder_out => bar_a
			);
	l2	:	recorder_target_floor PORT MAP (
				bar_recorder_in => bar_a,
				clock => clock,
				clear => clear,
				enable => enable_r,
				bar_recorder_out => bar_b
			);
	l3	: 	counter_source_floor PORT MAP (
				clock => clock,
				clear => clear,
				enable => enable_c,
				control => control_c,
				bar_counter_out => bar_c
			);
	l4	:	state_machine PORT MAP (
				bar_st_r_in => bar_b,
				bar_st_c_in => bar_c,
				clock => clock,
				enable_st_r => enable_r,
				enable_st_c => enable_c,
				control_st_c => control_c
			);
	l5	:	display_decoder PORT MAP (
				bar_decoder_in => bar_c,
				bar_decoder_out => bar_dp_decoder_out
			);
END arch;