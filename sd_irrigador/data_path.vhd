library ieee;
use ieee.std_logic_1164.all;

entity data_path is
port(
	rt1, rt2 : in bit;
	btn_reset: in bit;
	t1, t2 : out bit;
	T: out integer;
	clk_d : in bit
);
end data_path;

architecture main of data_path is


	signal and_out, tc : bit; -- Tc é um atribuidor para dizer qual dos timers está sendo contado
	signal Tv, sub_in: integer range 10 downto 0;
	signal counter_timer: integer range 50_000_000 downto 0;
	
	begin process(clk_d, rt1, rt2, tc)
		variable c1 : integer range 10 downto 0; -- temporizador do wait
		variable c2 : integer range 5 downto 0; -- temporizador do watering
	begin
	
		if ((clk_d'event and clk_d='0') and btn_reset='0') then	-- Quando resetado 
			tc <= '1'; -- 	
			Tv <= c1; -- temporizador recebe o time_wait (c1)
		end if;
	
	if ( (clk_d'event and clk_d='0') and (not(rt1) and rt2 and tc) = '1' ) then -- MUX | rt1 = 0; rt2 = 1; tc =1
			sub_in <= c1;

	elsif ( (clk_d'event and clk_d='0') and (not(rt1) and rt2 and tc) = '0' ) then
			sub_in <= c2;
	end if;
	
	
	if(clk_d'event and clk_d = '0') then
		if(Tv=1)then -- Etapa para alterar o Tc (tudo em Tv = 0 não funciona)
			tc <= not(tc);
			Tv <= Tv-1;
		elsif(Tv = 0) then -- Muda o contador, Tv recebe sub_in
			Tv <= sub_in;
			tc <= tc;
		else -- Decrementor
			Tv <= Tv-1;
			tc <= tc;
		end if;
		T <= Tv; -- Apenas para vermos no Waveform
		--wait for 1 sec;
	end if;
		t1 <= not(tc);
		t2 <= tc;
		
	end process;

end architecture main;
