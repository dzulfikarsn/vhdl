library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rom_128x8_sync is
	port(
		clock    :in std_logic;
		address  :in std_logic_vector(7 downto 0);
		data_out :out std_logic_vector(7 downto 0));
end entity rom_128x8_sync;

architecture rom_128x8_sync_arch of rom_128x8_sync is 
	constant LDA_IMM	: std_logic_vector (7 downto 0) := x"86";
	constant LDA_DIR	: std_logic_vector (7 downto 0) := x"87";
	constant LDB_IMM	: std_logic_vector (7 downto 0) := x"88";
	constant LDB_DIR	: std_logic_vector (7 downto 0) := x"89";
	constant STA_DIR	: std_logic_vector (7 downto 0) := x"96";
	constant STB_DIR	: std_logic_vector (7 downto 0) := x"97";
	constant ADD_AB 	: std_logic_vector (7 downto 0) := x"42";
	constant SUB_AB 	: std_logic_vector (7 downto 0) := x"43";
	constant AND_AB 	: std_logic_vector (7 downto 0) := x"44";
	constant OR_AB  	: std_logic_vector (7 downto 0) := x"45";
	constant INCA   	: std_logic_vector (7 downto 0) := x"46";
	constant INCB   	: std_logic_vector (7 downto 0) := x"47";
	constant DECA   	: std_logic_vector (7 downto 0) := x"48";
	constant DECB   	: std_logic_vector (7 downto 0) := x"49";
	constant BRA    	: std_logic_vector (7 downto 0) := x"20";
	constant BMI    	: std_logic_vector (7 downto 0) := x"21";
	constant BPL    	: std_logic_vector (7 downto 0) := x"22";
	constant BEQ    	: std_logic_vector (7 downto 0) := x"23";
	constant BNE    	: std_logic_vector (7 downto 0) := x"24";
	constant BVS    	: std_logic_vector (7 downto 0) := x"25";
	constant BVC    	: std_logic_vector (7 downto 0) := x"26";
	constant BCS     	: std_logic_vector (7 downto 0) := x"27";
	constant BCC    	: std_logic_vector (7 downto 0) := x"28";

  	type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);

	constant ROM : rom_type	:= (
		0	=> LDA_DIR,		-- Load A, [81]
		1	=> x"81",
		2	=> LDB_DIR,		-- Load B, [82]
		3	=> x"82",
		4	=> SUB_AB,		-- A - B
		5	=> BPL,			-- if A >= B, goto 9(x"09")
		6	=> x"09",
		7	=> LDA_DIR,		-- else, move B to A
		8	=> x"82",
		9	=> LDB_DIR,		-- Load B, [83]
		10	=> x"83",
		11	=> SUB_AB,		-- A - B
		12	=> BPL,			-- if A >= B, goto 16(x"10")
		13	=> x"10",
		14	=> LDA_DIR,		-- else, move B to A
		15	=> x"83",
		16	=> STA_DIR,		-- store A to [90]
		17	=> x"90",
		18	=> BRA,			-- address 18 (stay here)
		19	=> x"12",
		others => x"00"
	);
	
	signal EN : std_logic;

begin
	enable : process(address)
	begin 
		if ((to_integer(unsigned(address)) >= 0) and 
			(to_integer(unsigned(address)) <= 127)) then 
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;

	memory : process(clock)
	begin
		if(rising_edge(clock)) then
			if(EN = '1') then
				data_out <= ROM(to_integer(unsigned(address)));
			end if;
		end if;
	end process;

end architecture rom_128x8_sync_arch;