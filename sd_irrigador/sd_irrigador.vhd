library ieee;
use ieee.std_logic_1164.all;

entity sd_irrigador is
port(
	clk, N : in bit;
	btn : in bit;
	T: out integer;
	b1, b2: out bit;
	c0, c1 : out bit; -- estados
	--d1, d2 : out bit; -- t1,t2 temporizador
	hex_0_a : OUT STD_LOGIC;
   hex_0_b : OUT STD_LOGIC;
   hex_0_c : OUT STD_LOGIC;
   hex_0_d : OUT STD_LOGIC;
   hex_0_e : OUT STD_LOGIC;
   hex_0_f : OUT STD_LOGIC;
   hex_0_g : OUT STD_LOGIC
);

end sd_irrigador;

architecture main of sd_irrigador is
	signal rt1, rt2, t1, t2: bit; -- resetes e temporizadores associados

	
	component controller is
		port(N, t1, t2, clk, btn_reset: in bit;
			b1, b2, rt1, rt2, c0, c1 : out bit;
			hex_0_a, hex_0_b, hex_0_c, hex_0_d, hex_0_e, hex_0_f, hex_0_g : out STD_LOGIC
			);
	end component;
	
		component data_path is
		port(rt1, rt2, btn_reset, clk_d : in bit;
			t1, t2 : out bit;
			T : out integer
			);
	end component;
	
	
begin
	--t1 <= '0';
	--t2 <= '0';
	
	inst_control: controller PORT MAP(N => N, t1 => t1, t2 => t2, clk => clk, b1 => b1, b2 => b2, rt1 => rt1, rt2 => rt2, btn_reset => btn, c0 => c0, c1 => c1,hex_0_a=>hex_0_a, hex_0_b=>hex_0_b, hex_0_c=>hex_0_c, hex_0_d=>hex_0_d, hex_0_e=>hex_0_e, hex_0_f=>hex_0_f, hex_0_g=>hex_0_g); -- Em paralelo com Data_path
	
	inst_datapath: data_path PORT MAP(rt1 => rt1, rt2 => rt2, btn_reset=> btn, clk_d => clk, t1 => t1, t2 => t2, T=>T); -- Em paralelo com Controller

	--inst_led_hex: led_hex PORT MAP(c1 => c1, c0=>c0, hex_0_a=>hex_0_a, hex_0_b=>hex_0_b, hex_0_c=>hex_0_c, hex_0_d=>hex_0_d, hex_0_e=>hex_0_e, hex_0_f=>hex_0_f, hex_0_g=>hex_0_g);
	
	--d1 <= t1;
	--d2 <= t2;
	
end architecture main;