# vending_machine

A mock vending machine written in vhdl for the Digilent Basys 3 board. Currently unfinished.  
  
The device has two operating modes: Purchasing mode, and Programming mode.  
The purchasing mode is the normal operating mode where a user is able to insert money and order an item.  
The programming mode allows a tech to program the prices of each slot.  
  
# Purchasing Mode
### Input

BTNC: Reset System  
BTNU: Insert a nickel  
BTNQ: Insert a quarter  
BTND: Inster a dollar  
BTNL: Return Change (Also clears input keypad presses)
  
PmodKYPD: 16 button keypad with numbers 0 through 9 and letters A through F. Used to choose which item to purchase.  
  
SW0: When low, device is operating in purchasing mode. When high the device is operating in programming mode.  
  
### Output

Seven Segment Display: Displays the current amount of money that has been deposited or blinks the price of the item if the current amount of money entered is too low.  

PmodOLED: Undetermined. May have all the different prices scroll across the screen, or mimic the output of the seven segment display. Mostly want it for the experience in using it.

# Programming Mode
### Input

BTNC: Reset System  
BTNU: N/A
BTNQ: N/A 
BTND: N/A  
BTNL: Program slot with current price entered.  
  
PmodKYPD: 16 button keypad with numbers 0 through 9 and letters A through F. Used to choose which item to program.
  
SW15: When low, device is operating in purchasing mode. When high the device is operating in programming mode.  
  
### Output

Seven Segment Display: Displays current price entered for the slot that has been chosen.

PmodOLED: Undetermined. May have all the different prices scroll across the screen, or mimic the output of the seven segment display. Mostly want it for the experience in using it.
