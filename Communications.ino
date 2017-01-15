/* UMS - Communications
   
   The Send() function is used for sending data points to MATLAB. Done
   so by simply reading which valeue is requested and then prints the 
   value to Serial(one).
   
   by Tausif Sharif
*/

void Send()
{
  if(Serial1.available() > 0)      // Checking for any data sent by PC
  {
    mode = Serial1.read();
    switch(mode)
    {
      case 'R':
        r = UpdateRadius();
        Serial1.println(r);
        break;
        
      case 'H':
        h = UpdateHeight();
        Serial1.println(h);
        break;
        
      case 'A':
        Serial1.println(angle);
        break;
      
      default:
        break;     
    }
  }
}
