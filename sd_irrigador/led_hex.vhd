library ieee;
use ieee.std_logic_1164.all;

entity led_hex is
port(
		c1, c0 : in bit; -- bits dos estados
		hex_0_a, hex_0_b, hex_0_c, hex_0_d, hex_0_e, hex_0_f, hex_0_g : out STD_LOGIC -- bits do sete segmento
	
);
end led_hex;

architecture main of led_hex is

	signal s1,s0: bit; 
	
	begin process(c1, c0)
	begin
	
		if (c1='0' and c0='0') then -- Estado 00 init			
			 hex_0_a <= '1';
			 hex_0_b <= '0';
			 hex_0_c <= '0';
			 hex_0_d <= '1';
			 hex_0_e <= '1';
			 hex_0_f <= '1';
			 hex_0_g <= '1';
		elsif(c1 = '0' and c0 = '1') then -- Estado 01 wait
			 hex_0_a <= '0';
			 hex_0_b <= '0';
			 hex_0_c <= '1';
			 hex_0_d <= '0';
			 hex_0_e <= '0';
			 hex_0_f <= '1';
			 hex_0_g <= '0';
		elsif(c1 = '1' and c0 = '0') then -- Estado 10 filling
			 hex_0_a <= '0';
			 hex_0_b <= '0';
			 hex_0_c <= '0';
			 hex_0_d <= '0';
			 hex_0_e <= '1';
			 hex_0_f <= '1';
			 hex_0_g <= '0';
		elsif(c1 = '1' and c0 = '1') then -- Estado 11 watering
			 hex_0_a <= '1';
			 hex_0_b <= '0';
			 hex_0_c <= '0';
			 hex_0_d <= '1';
			 hex_0_e <= '1';
			 hex_0_f <= '0';
			 hex_0_g <= '0';
		end if;

	end process;

end architecture main;