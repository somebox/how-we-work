/* Image Library */
HashMap<String, ImageSequence> image_library = new HashMap<String, ImageSequence>();

class ImageSequence {
  PImage[] images;
  int base_name;
  int frame_count;
  float scale;
   
  ImageSequence(String base_name, int img_count, float img_scale){
    scale = img_scale;
    frame_count = img_count;
    images = new PImage[frame_count];
    for (int i = 0; i < frame_count; i++) {   
      String filename = base_name + "-" + nf(i, 2) + ".png";
      //println("loading "+filename);
      images[i] = loadImage(filename);
    }
  }
}

void load_images(){
  load_sequence("person/person-typing", 2, 1.0);
  load_sequence("person/person-idle", 7, 1.15);
  load_sequence("person/person-sleeping", 4, 1.0);
  load_sequence("person/person-talking", 8, 1.0);
  // ...
}

// loads a set of numbered images, up to 100. The base name and number are joined with a dash, numbers are padded with two zeros. So, "person", 3 will load "person-00",
void load_sequence(String base_name, int image_count, float scale){
  ImageSequence img = new ImageSequence(base_name, image_count, scale);
  image_library.put(base_name, img);
}



/* -------------  Position: manages position, offsets and scale. All sprites have a position  ----------------- */

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

/* --------------   Sprite: base class for all visual objects (except UI, which is controlP5) */

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

// -----------  Animation : image sequence  ----------  //

class Animation extends Sprite {
  int speed;      // 0=paused, 1=fastest possible, n>1 get slower by waiting n frames
  float scale;
  int frame;      // current frame
  ImageSequence image_sequence;
  
  Animation(){
    super();
    frame = 0;
    scale = 1.0;
    speed = 1;
  }
  
  Animation(String identifier) {
    super();
    image_sequence = image_library.get(identifier);
  }
  
  void set_image_sequence(ImageSequence img_seq){
    image_sequence = img_seq;
  }

  void next_frame(){
    frame = (frame+1) % image_sequence.frame_count;
  }
  
  void random_frame(){
    frame = ceil(random(image_sequence.frame_count));
  }

  void draw() {
    PImage image = image_sequence.images[frame];
    float base_scale = image_sequence.scale;
    float w = image.width * base_scale * scale;
    float h = image.height * base_scale * scale;
    image(image, pos.x-(w/2), pos.y-(w/2), w, h);
  }
  
  int width() {
    return image_sequence.images[frame].width;
  }
}

/* ----------   Progress circle  ------------  */

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


/* backlog column */

void draw_backlog_column(ArrayList<Activity> list, Position loc, String name, int column_num, color c){
  int max_col_items = 6;  // max vertical items
  int size = loc.size;
  int spacing = 10;
  int x = loc.x + (loc.size+spacing)*column_num;
  int y = loc.y;
  
  // column name
  fill(#000000);
  text(name, x, y-spacing*3);
  
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
