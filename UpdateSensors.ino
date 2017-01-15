/* UMS - Update Sensors
   
   Here the UpdateRadius() and UpdateHeight() functions simply update
   to the most recent values when requested.
   
   by Tausif Sharif
*/

unsigned int UpdateRadius()
{
  SRF02::update();
  r = radius.read();
  return r;
}

unsigned int UpdateHeight()
{
  SRF02::update();
  h = height.read();
  return h;
}
