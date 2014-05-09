CE5_Rios
========

MIPS Computer Exercise:

__________________________________________________________________________

TASK #1: Simple MIPS Assembly Program (5pts all or nothing):

(Assembly Program )

Addi $s0, $0, 44	|	# $s0 is initialized to equal 44. ($s0 = 0 + 44)

Addi $s1, $0, -37	| #$s1 is initialized to equal -37. ($s1 = 0 - 37)

Add $s0, $s1, $s2	| #$s2 is initialized to equal the sum of $s1 and $s2. ($s2 = $s0 + $s1)

Sw $s2, 0x54($0)	| #$s2 is stored in the hexadecimal memory address x54.

___________________________________________________________________________

TASK #2: Machine Code (35pts):

(Machine Code)

Addi $s0, $0, 44		  001000 | 00000 | 10000 | 0000 0000 0010 1100		    0x2010002C
 
Addi $s1, $0, -37	  001000 | 00000 | 10001 | 1111 1111 1101 1011		    0x2011FFDB

Add $s2, $s0, $s1	  000000 | 10000 | 10001 | 10010 | 00000 | 100000	  0x02119020

Sw $s2, 0x54($0)	   101011 | 00000 | 10010 | 0000 0000 0101 0100		    0xAC120054

![pic1] (https://raw.github.com/John-Rios/CE5_Rios/master/Task2_MC.jpg)

(Signal Descriptions) 
 
(Waveform)

Each function occurs per clock cycle. There is a 100 ns delay, as programmed, followed by 44 being loaded into memory location 16. -37 is then loaded into memory location 17 on the next clock cycle. On the next clock cycle, the sum of memory location 16 and 17 are loaded to memory location 18. Finally, the data in memory location 18 is written to the designated memory location. "memwrite" goes active high and remains there for the duration of the simulation. I believe this is a correct simulation leading me to believe my work is correct.

![pic2] (https://raw.github.com/John-Rios/CE5_Rios/master/Task2_WF_correct.jpg)

____________________________________________________________________________

TASK #3: You now need to modify the MIPS single-cycle processor by adding the ori 
Instruction (60pts):

 Design (20 pts)
 
  Schematic Modification 
      
  -I am 90% sure that you do not have to make any changes to the given schematic. Hopefully this is true otherwise the rest of my CE is incorrect.    
  
  ALU Decoder Table Modification 
  
|Instruction | OP5:0 | RegWrite | RegDst | AluSrc | Branch | MemWrite | MemtoReg | ALUOp1:0 | 
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|R-type|000000|1|1|0|0|0|0|10|
|lw|100011|1|0|1|0|0|1|00|
|sw|101011|0|x|1|0|1|x|00|
|beq|000100|0|x|0|1|0|x|01|
|addi|001000|1|0|1|0|0|0|00|
|j|000100|0|x|0|x|0|x|xx|
|ori|001101|1|0|1|0|0|0|11|

  
  -The ALU decoder could handle the additional function of ori. This meant that all I needed to do was add in a line of code for the or function. Below shows where I added in the required code for ori.
  
  ![pic3] (https://raw.github.com/John-Rios/CE5_Rios/master/Task3_ALUcode.jpg)

  Main Decoder Modification 
  
  -The main decoder was capable of handling the desired additional function. To accomplish this all I needed to do was add an additional line of code. Below shows my addition to the mips file.
  
  ![pic4] (https://raw.github.com/John-Rios/CE5_Rios/master/Task3_Maincode.jpg)
  
   Functionality (40 pts) 

 VHDL Modifications 

Addi $s0, $0, 44		001000 | 00000 | 10000 | 0000 0000 0010 1100		0x2010002C

Addi $s1, $0, -37	001000 | 00000 | 10001 | 1111 1111 1101 1011		0x2011FFDB

Add $s2, $s0, $s1	000000 | 10000 | 10001 | 10010 | 00000 | 100000	0x02119020

Ori $S3, $S2, x8000	001101 | 10010 | 10011 | 1000 0000 0000 0000		0x36538000

Sw $s2, 0x54($0)	101011 | 00000 | 10010 | 0000 0000 0101 0100		0xAC120054

![pic5] (https://raw.github.com/John-Rios/CE5_Rios/master/Task3_MC.jpg)

Testing Waveform

Each function occurs per clock cycle. There is a 100 ns delay, as programmed, followed by 44 being loaded into memory location 16. -37 is then loaded into memory location 17 on the next clock cycle. On the next clock cycle, the sum of memory location 16 and 17 are loaded to memory location 18. On the next clock cycle an OR is performed where what is written into memory location 18 is selected because memory location 19 is all zeros. Finally, the data in memory location 18 is written to the designated memory location. "memwrite" goes active high and remains there for the duration of the simulation. I believe this is a correct simulation leading me to believe my work is correct.

![pic6] (https://raw.github.com/John-Rios/CE5_Rios/master/Task3_WF.jpg)


____________________________

Debugging and Errors: (Task 2) At first I was running into errors with my test bench file. I was unable to identify the problem until a class wide email was sent out describing an error due to mismatched file names. Upon learning of the reason, I was able to correct the error by creating a new test bench file with the appropriate name. (Task 2) I ran into an error when first simulating. I put all of my code in binary in one string with no breaks for the four instructions. Initially, I thought the computer would read the 1s and 0s in 32 bit chunks performing each function. However, I soon realized the computer was telling me it expected the numbers in smaller chunks which led me to creating a line of code for each individual function. After referring to my class notes I decided I should try to write the text in hex rather than binary. This seemed to solve my problem. (Task 3) I accidently made a file inside of the file that my repository was initialized in. This made uploading my mips.vhd file difficult because I needed two repositories to upload to the same location. I figured out how to upload my mips.vhd file but did bad git hub practices to do it. 

____________________________

Documentation: C2C Scott Agnolutto helped me understant the control unit main decoder table. I used the course text, the course sharepoint resources (lesson slides), and a binary to hex converter on google (i do not remember the actual one) to check my conversions.  
