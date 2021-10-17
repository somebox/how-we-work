class Position {
  int x, y, size;
  
  Position(int xpos, int ypos, int sz){
    x=xpos;
    y=ypos;
    size=sz;
  }
  
  Position offset(int xoff, int yoff){
     return new Position(x+xoff, y+yoff, size); 
  }
  
  Position offset(Position p){
    return new Position(x+p.x, y+p.y, size);
  }
}

class Sprite {
  Position pos;
  float rot;
  boolean visible;
  
  Sprite(){
    rot = 0;
    visible = true;
    pos = new Position(0,0,1);
  }
  
  Sprite(Position p){
    super();
    set_position(p);
  }
 
  void set_position(int xpos, int ypos){
    pos.x = xpos;
    pos.y = ypos;
  }

  void set_position(int xpos, int ypos, int sz){
    pos.x = xpos;
    pos.y = ypos;
    pos.size = sz;
  }

  void set_position(Position p){
    pos.x = p.x;
    pos.y = p.y;
    pos.size = p.size;
  }
  
  void move_to(Position p, int time){
    // animate into position
  }
    
  void draw(){
  }
}

class Progress extends Sprite {
  float percent = 0.0;    // 0.0 - 1.0
  
  Progress(Position p){
    super();
    set_position(p);
  }
  
  void draw(){
    arc(pos.x, pos.y, pos.size, pos.size, 0, PI*2*percent, PIE);
  }
  
}

void draw_backlog_column(ArrayList<Activity> list, Position loc, String name, int column_num, color c){
  int max_col_items = 6;  // max vertical items
  int size = loc.size;
  int spacing = 7;
  int x = loc.x + (loc.size+spacing)*column_num;
  int y = loc.y;
  
  // column name
  fill(#ffffff);
  text(name, x, y-spacing*2);
  
  // draw activity cards
  for (int i=0; i < list.size(); i++){
    Activity a = list.get(i);
    int card_x = x + (loc.size+spacing)*floor(i/max_col_items);
    int card_y = y + (loc.size+spacing)*(i % max_col_items);
    a.set_position(new Position(card_x, card_y, size));
    a.card_color = c;
    a.draw();
  }
}
