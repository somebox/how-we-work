class DisplayLocation{
  int x, y, size;
  
  DisplayLocation(int xpos, int ypos, int sz){
    x = xpos;
    y = ypos;
    size = sz;
  }
}

class Progress{
  DisplayLocation loc;
  float percent = 0.0;    // 0.0 - 1.0
  
  Progress(DisplayLocation location){
    loc = location;
  }
  
  void draw(){
    arc(loc.x, loc.y, loc.size, loc.size, 0, PI*2*percent, PIE);
  }
  
}
