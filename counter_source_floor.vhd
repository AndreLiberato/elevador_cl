ENTITY counter_source_floor IS PORT(
	enbl	:	IN	BIT;
	clr	:	IN	BIT;
	ctrl	:	IN	BIT;
	clk	:	IN	BIT;
	c_out	:	OUT	BIT_VECTOR(3 DOWNTO 0)
	
);
END counter_source_floor;

ARCHITECTURE arch OF counter_source_floor IS
	SIGNAL counter: BIT_VECTOR(3 DOWNTO 0);
BEGIN
	PROCESS (clk, clr, enbl, ctrl, counter)
   	BEGIN
		IF (clr = '1') THEN
	   		counter <= "0001";
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF enbl = '1' THEN
				IF ctrl = '1' THEN
					CASE counter IS
           					WHEN "1001" => counter <= "0001";
            					WHEN "0001" => counter <= "0010";
            					WHEN "0010" => counter <= "0011";
            					WHEN "0011" => counter <= "0100";
            					WHEN "0100" => counter <= "0101";
            					WHEN "0101" => counter <= "0110";
            					WHEN "0110" => counter <= "0111";
            					WHEN "0111" => counter <= "1000";
						WHEN "1000" => counter <= "1001";
						WHEN OTHERS => counter <= "0000";
        				END CASE;
					c_out <= counter;
				ELSE
					CASE counter IS
           					WHEN "1001" => counter <= "1000";
            					WHEN "0001" => counter <= "1001";
            					WHEN "0010" => counter <= "0001";
            					WHEN "0011" => counter <= "0010";
            					WHEN "0100" => counter <= "0011";
            					WHEN "0101" => counter <= "0100";
            					WHEN "0110" => counter <= "0101";
            					WHEN "0111" => counter <= "0110";
						WHEN "1000" => counter <= "0111";
						WHEN OTHERS => counter <= "0000";
        				END CASE;
					c_out <= counter;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;