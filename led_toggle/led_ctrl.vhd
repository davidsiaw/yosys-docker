LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY led_toggle IS
    PORT (
        clk : IN STD_LOGIC;
        btn : IN STD_LOGIC;
        led : OUT STD_LOGIC
    );
END led_toggle;

ARCHITECTURE Behavioral OF led_toggle IS
    SIGNAL btn_sync_0 : STD_LOGIC := '1';
    SIGNAL btn_sync_1 : STD_LOGIC := '1';

    SIGNAL debounce_cnt : unsigned(19 DOWNTO 0) := (OTHERS => '0');
    SIGNAL btn_debounced : STD_LOGIC := '1';

    SIGNAL btn_prev : STD_LOGIC := '1';
    SIGNAL led_reg : STD_LOGIC := '0';

BEGIN

    PROCESS (clk)
        VARIABLE cnt_press : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            btn_sync_0 <= btn;
            btn_sync_1 <= btn_sync_0;

            IF (btn_sync_1 = btn_debounced) THEN
                debounce_cnt <= (OTHERS => '0');
            ELSE
                debounce_cnt <= debounce_cnt + 1;

                IF (debounce_cnt = x"FFFFF") THEN
                    btn_debounced <= btn_sync_1;
                    debounce_cnt <= (OTHERS => '0');
                END IF;
            END IF;

            btn_prev <= btn_debounced;

            IF (btn_prev = '1' AND btn_debounced = '0') THEN
                cnt_press := cnt_press + 1;
                IF (cnt_press = 4) THEN
                    cnt_press := 0;
                    led_reg <= NOT led_reg;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    led <= led_reg;

END Behavioral;