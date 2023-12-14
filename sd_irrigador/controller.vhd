library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(
		N, t1, t2 : in bit; -- t1 = Tempo de espera para irrigar; t2 = tempo de irrigação
		b1, b2, rt1, rt2 : out bit; -- b1 = Bomba do tanque; b2 = Bomba de irrigar 
		clk: in bit;
		btn_reset: in bit;
		c0, c1 : out bit;
		hex_0_a, hex_0_b, hex_0_c, hex_0_d, hex_0_e, hex_0_f, hex_0_g : out STD_LOGIC
);
end controller;

architecture main of controller is

	signal s1,s0,n1,n0: bit; -- nem ideia do que seja
	
	begin process(clk, N, s1, s0, n1, n0, btn_reset)
	begin
		s1 <= n1;
		s0 <= n0;
		c0 <= s0;
		c1 <= s1;
		if (btn_reset='0') then			
			n1 <= '0';
			n0 <= '0';
			rt1 <= '1';
		--end if;
		

	-- declarar rt1 e rt2;
		elsif((clk'event and clk='0') and (s1= '0' and s0 = '0')) then -- estado init
			n0 <= '1';
			n1 <= '0';
			rt1 <= '1';
		elsif((clk'event and clk='0') and (s1= '0' and s0 = '1')) then -- estado wait || falta garantir quando N = 0 AND t1 = 0
			rt1 <= '0'; -- Garante que tudo esteja devidamente desligado 
			rt2 <= '0';
			b2 <= '0';
			b1 <= '0';
			if(N ='0' and t1='1') then -- transita para o estado filling
				n0 <= '0';
				n1 <= '1';
			elsif(N='1' and t1='0') then -- transita para o estado watering
				rt2 <= '1';
				n0  <= '1';
				n1  <= '1';
			end if;
		elsif((clk'event and clk='0') and (s1= '1' and s0 = '0')) then -- estado filling
			b2<='0'; -- Garante que a  bomba do irrigador esteja desligada ao chegar nesse estado 
			if(N = '0') then -- Aciona a bomba do tanque e mantém o estado
				b1 <= '1';
				n0 <= '0';
				n1 <= '1';
			else -- Volta para o estado waiting, mantém a bomba
				b1 <= '1';
				n0 <= '1';
				n1 <= '0';				
			end if;
		elsif((clk'event and clk='0') and (s1= '1' and s0 = '1')) then -- estado watering
			b1<='0'; -- Garante que a bomba do tanque esteja desligada ao chegar nesse estado
			if(N='1' and t2='1') then -- Começa a irrigar e mantém o estado
				b2 <= '1';
				n0 <= '1';
				n1 <= '1';
			elsif(t2 = '0') then -- Volta para o estado waiting 
				rt1 <= '1';
				b2 <= '1';
				n0 <= '1';
				n1 <= '0';
			end if;
		end if;
		
		if (s1='0' and s0='0') then -- Estado 00 init			
			 hex_0_a <= '1';
			 hex_0_b <= '0';
			 hex_0_c <= '0';
			 hex_0_d <= '1';
			 hex_0_e <= '1';
			 hex_0_f <= '1';
			 hex_0_g <= '1';
		elsif(s1 = '0' and s0 = '1') then -- Estado 01 wait
			 hex_0_a <= '0';
			 hex_0_b <= '0';
			 hex_0_c <= '1';
			 hex_0_d <= '0';
			 hex_0_e <= '0';
			 hex_0_f <= '1';
			 hex_0_g <= '0';
		elsif(s1 = '1' and s0 = '0') then -- Estado 10 filling
			 hex_0_a <= '0';
			 hex_0_b <= '0';
			 hex_0_c <= '0';
			 hex_0_d <= '0';
			 hex_0_e <= '1';
			 hex_0_f <= '1';
			 hex_0_g <= '0';
		elsif(s1 = '1' and s0 = '1') then -- Estado 11 watering
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