--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:27:01 05/08/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Rios/Documents/ECE281/CE5/mips_tb.vhd
-- Project Name:  CE5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mips
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mips_tb IS
END mips_tb;
 
ARCHITECTURE behavior OF mips_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mips
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pc : INOUT  std_logic_vector(31 downto 0);
         instr : IN  std_logic_vector(31 downto 0);
         memwrite : OUT  std_logic;
         aluout : INOUT  std_logic_vector(31 downto 0);
         writedata : INOUT  std_logic_vector(31 downto 0);
         readdata : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal instr : std_logic_vector(31 downto 0) := (others => '0');
   signal readdata : std_logic_vector(31 downto 0) := (others => '0');

	--BiDirs
   signal pc : std_logic_vector(31 downto 0);
   signal aluout : std_logic_vector(31 downto 0);
   signal writedata : std_logic_vector(31 downto 0);

 	--Outputs
   signal memwrite : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mips PORT MAP (
          clk => clk,
          reset => reset,
          pc => pc,
          instr => instr,
          memwrite => memwrite,
          aluout => aluout,
          writedata => writedata,
          readdata => readdata
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		instr <= X"2010002C"; --Task 1: load 44 into register $S0
		wait for clk_period;  

		instr <= X"2011FFDB"; --Task 1: load -37 into register $s1
		wait for clk_period; 
		
		instr <= X"02119020"; --Task 1: add $S0 and $S1 and store in register $S2 
		wait for clk_period; 
		
		instr <= X"36538000"; --Task 3: ORs $S2 and $S3 and stores in the hexadecimal location x8000 (ori $S3, $S2, x8000)
		wait for clk_period; 
		
		instr <= X"AC120054"; --Task 1: writes $S2 to the hexadecimal memory address x54
		wait for clk_period; 
		
      wait;
   end process;

END;
