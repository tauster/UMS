/* UMS - Write to SD
   
   The WriteSD() function is used to print the raw coordinate onto the
   SD card. Print is formatted as such so MATLAB's dlmread() function
   can import coordinates quickly.
   
   by Tausif Sharif
*/

void WriteSD()
{
  dataLog = SD.open("dataLog.txt", FILE_WRITE);
  
  if(dataLog)
  {
    dataLog.print(r); dataLog.print(" ");
    //delay(10);
    dataLog.print(h); dataLog.print(" ");
    //delay(10);
    dataLog.println(angle);
    //delay(10);
    dataLog.close();
  }
}
