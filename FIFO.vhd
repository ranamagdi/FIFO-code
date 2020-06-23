----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:59:48 05/13/2020 
-- Design Name: 
-- Module Name:    FIFO - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FIFO is
generic ( width: integer:=8  );

    Port ( reset : in  std_logic;
           rclk : in std_logic;
           wclk : in  std_logic;
           rreq : in  std_logic;
           wreq : in std_logic;
           datain : in std_logic_vector(width-1 downto 0);
           dataout : out std_logic_VECTOR(width-1 downto 0);
           empty : out  std_logic;
           full : out  std_logic);
end FIFO;

architecture Behavioral of FIFO is
type FIFO_Memory is array (0 to 15) of std_logic_VECTOR (width - 1 downto 0);
signal Memory : FIFO_Memory :=(others => (others => '0'));   
signal empty_s,full_s :std_logic:='0';
signal r_ptr, w_ptr : integer :=0;


begin
empty<=empty_s;
 full<=full_s; 
 
p:process (rclk,wclk ,reset)
variable counter : integer := 0; 

begin
   
if (reset ='1')then
dataout <=(others => '0');
empty_s <='1';
full_s <='0';
r_ptr<=0;
w_ptr<=0;
counter:=0;
else
if(rising_edge(wclk)) then
if(wreq='1' and full_s ='0' ) then
  -- Write Data to Memory
      Memory(w_ptr)<= datain;
		w_ptr<=w_ptr+1;
		counter:=counter+1;
		end if;
	   end if;
		  
if(rising_edge(rclk) )then	  
 if(rreq='1' and empty_s ='0' ) then
  -- Update data output
		dataout <= Memory(r_ptr)  ;
		r_ptr <= r_ptr+1;
		counter:=counter-1;
		end if;
		end if;
		 if(w_ptr = 15) then      
        w_ptr <= 0;
        end if;
		  
		if(r_ptr = 15) then      
       r_ptr <= 0;
        end if;
		  
		 
	   --setting empty and full flags.
        if(counter = 0) then
            empty_s <= '1';
        else
            empty_s <= '0';
        end if;
        if(counter = 16) then
            full_s <= '1';
        else
            full_s <= '0';
        end if;
    end if; 
	 
	 

    end process;
						


end Behavioral;

