--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:38:10 05/14/2020
-- Design Name:   
-- Module Name:   D:/FIFO/FIFO_test.vhd
-- Project Name:  FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FIFO
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY FIFO_test IS
END FIFO_test;
 
ARCHITECTURE behavior OF FIFO_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO
    PORT(
         reset : IN  std_logic;
         rclk : IN   std_logic;
         wclk : IN   std_logic;
         rreq : IN   std_logic;
         wreq : IN   std_logic;
         datain : IN std_logic_vector(7 downto 0);
         dataout : out std_logic_vector(7 downto 0);
         empty : out std_logic;
         full : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset :std_logic := '0';
   signal rclk : std_logic := '0';
   signal wclk : std_logic := '0';
   signal rreq : std_logic := '0';
   signal wreq : std_logic := '0';
   signal datain : std_logic_vector(7 downto 0) := (others => '0');
   signal dataout : std_logic_vector(7 downto 0) := (others => '0');
   signal empty : std_logic := '0';
   signal full : std_logic := '0';
	--temporary signals
    signal i : integer := 0;

   -- Clock period definitions
   constant rclk_period : time := 10 ns;
   constant wclk_period : time := 10 ns;
	constant depth : integer := 16;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO PORT MAP (
          reset => reset,
          rclk => rclk,
          wclk => wclk,
          rreq => rreq,
          wreq => wreq,
          datain => datain,
          dataout => dataout,
          empty => empty,
          full => full
        );

   -- Clock process definitions
   rclk_process :process
   begin
		rclk <= '0';
		wait for rclk_period/2;
		rclk <= '1';
		wait for rclk_period/2;
   end process;
 
   wclk_process :process
   begin
		wclk <= '0';
		wait for wclk_period/2;
		wclk <= '1';
		wait for wclk_period/2;
   end process;
 
     stim_proc: process
	   begin		
		
	 reset <= '1';
		
	 wait for 10 ns;
		
		reset <= '0';
	 
		wreq<='1';rreq<='0';
		for i in 1 to 10 loop   --write 10 values to fifo.
       datain <= conv_std_logic_vector(i,8);
         wait for 10 ns;
      end loop; 
		
		wreq<='0';rreq<='1';   --read 4 values from fifo
		wait for 40 ns;
		wreq<='0';rreq<='0';
		wait for 100 ns;
		
		wreq<='1';rreq<='0';
		for i in 1 to 10 loop   --write 10 values to fifo.
       datain <= conv_std_logic_vector(i,8);
         wait for 10 ns;
      end loop; 

		  for i in 1 to 10 loop   --write 10 values to fifo.
       datain <= conv_std_logic_vector(i,8);
         wait for 10 ns;
      end loop; 
		 
		wait;
		
	
	end process;
END;
