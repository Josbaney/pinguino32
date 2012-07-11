/*
 * This applications shows how to read and change 32-bit Pinguino clock settings
 */

u32 cpuFrequency;
u32 peripheralFrequency;

void setup()
{                
  CDC.printf("CDC: Hello\n");

  // Show current settings
  
  cpuFrequency = System.getCpuFrequency();
  CDC.printf("\nCPU       : %d MHz\r\n", cpuFrequency / 1000 / 1000);

  peripheralFrequency = System.getPeripheralFrequency();
  CDC.printf("Peripheral: %d MHz\r\n", peripheralFrequency / 1000 / 1000);
  
  // Change current register settings 
  
  System.setCpuFrequency(cpuFrequency / 2); // should be 40 MHz
  System.setPeripheralFrequency(peripheralFrequency / 4); // should be 10 MHz
  
  // Show new current settings
  
  cpuFrequency = System.getCpuFrequency();
  CDC.printf("\nCPU       : %d MHz\r\n", cpuFrequency / 1000 / 1000);

  peripheralFrequency = System.getPeripheralFrequency();
  CDC.printf("Peripheral: %d MHz\r\n", peripheralFrequency / 1000 / 1000);
}

void loop()
{
}
