import java.util.Collections;
import controlP5.*;

/* 

CALENDAR SIMULATOR

Shows visually how available time fill up quickly, as people try to schedule the next available slot.

For this simulation, we use a simplified calendar concept. Months and years don't matter, every
week is five days, every day is 20 time units long (with each unit being approximately 20m long).

*/


Calendar cal;
static final int TIME_UNITS_PER_DAY = 20;
int t = 0;       // tracks the ticks every frame
int speed = 1;  // time units per tick

void setup() {
  size(1920, 1080);
  frameRate(30);
  setup_ui();
  cal = new Calendar(300,300,500,1200);
  cal.add_days(14);
}

void draw() {
  background(#ffffff);
  cal.draw();
  cal.tick(t++);
  if (random(10) > 9) add_random_event(t);
  if (random(100) > 98) delete_random_event();
  cp5.getController("sp_number").setStringValue("Day "+cal.current_day);
}

void add_random_event(int t){
  int duration = int(random(6)<5 ? random(2)*2+1 : random(3)*2+2);  // mostly short one, a few long ones
  int start = int(random(TIME_UNITS_PER_DAY-duration));
  Event e = new Event(start, duration, int(random(3)));
  int proposed_day = 1+int(random(6));
  println("adding: "+proposed_day);
  e.summary();
  while (proposed_day < 12){
     Workday day = cal.get_day(proposed_day+cal.current_day);
     if (day != null) {
       if (day.schedule_event(e)){
         println(" placed event on on day "+day.day_number);
         return;
       }
     }
     proposed_day++;
  }
  println(" no time found");
}

void delete_random_event(){
  int proposed_day = 3+int(random(5));
  while (proposed_day < 12){
     Workday day = cal.get_day(proposed_day+cal.current_day);
     int num = int(random(day.events.size()));
     if (day.events.size() == 0){ return; }
     Event e = day.events.get(num);
     if (e!=null) { 
       day.events.remove(num);
       return;
     }
  }
}

/* ----- Support Classes ------ */

class Event implements Comparable<Event> {
  int start_time;
  int age = 0;
  int duration; // 1-20 time units
  int prio; // 1=urgent, 2=important, 3=normal
  
  Event(int start, int duration, int prio){
    this.duration = duration;
    this.start_time = start;
    this.prio = prio;
  }

  void offset_by(int units){
     start_time += units;
  }  

  int end_time(){
    return(start_time+duration);
  }
  
  color prio_color(){
     switch(prio){
       case 0: return(#559933);
       case 1: return(#88ffff);
       case 2: return(#ffff88);
       case 3: return(#ff8888);
       default: return(#888888);
     }
  }
  
  void draw(int w, int h){
    fill(prio_color());
    int y = 10+(h-20)/TIME_UNITS_PER_DAY*start_time;
    rect(10, y, w-20, (h-20)/TIME_UNITS_PER_DAY*(duration));
    textSize(14);
    fill(#444444);
    text(start_time+"-"+end_time(), 20, y+20);
    age++;
  }
  
  void summary(){
    println(" event - start:"+start_time+" end:"+end_time()+" prio:"+prio); 
  }
  
  @Override
    int compareTo(Event other) {
      return this.start_time - other.start_time;
    }
}

class Workday {
  int id;
  int day_number;
  ArrayList<Event> events = new ArrayList<Event>();
  
  Workday(int id, int day_number){
    this.day_number = day_number;
    this.id = id;
  }
  
  boolean is_weekend(){
    return(id % 7 < 2);
  }
  
  boolean is_overlapping(Event event, int offset){
    // search through all scheduled events and check for any overlaps with the proposed event
    for (Event e: events){
      if (
        // (StartA <= EndB)  and  (EndA >= StartB)
        (event.start_time + offset <= e.end_time() && event.end_time() + offset >= e.start_time) 
       ){
        return(true); // conflict with this event
      }
    }
    return(false); // no overlaps found
  }
  
  boolean schedule_event(Event event){
    int offset=0;
    if (is_weekend()) return false;
    while(offset<TIME_UNITS_PER_DAY){
      if (!is_overlapping(event, offset)){
        if (event.end_time()+offset <= TIME_UNITS_PER_DAY){   // doesn't pass the end-of-day
          event.offset_by(offset);
          events.add(event);    
          return(true);
        }
      }
      offset++;
    }
    return false; // no match
  }
  
  void draw(int w, int h){
    if (is_weekend()){ 
      fill(#bbbbbb); noStroke(); 
    } else { 
      fill(#ffffff); stroke(#bbbbbb);
    }
    rect(0,0,w,h);
    textSize(40);
    fill(#888888);
    text(str(day_number), 10, -30);
    for (Event e: events){
      e.draw(w,h);
    }
  }
  
}


class Calendar {
  ArrayList<Workday> days = new ArrayList<Workday>();
  
  int visible_days;  // number of visible days
  int month_len;     // virtual length of current month
  int current_day;   // current day, ever-increasing
  int current_time;  // 20 units per day
  int month_day;     // the virutal day-of-the-month, resets at month_len
  int max_day;       // the highest day number used so far
  int h,w,x,y;
  
  Calendar(int x, int y, int h, int w){
    visible_days = 8;
    month_len = 30;
    current_day = 1;
    current_time = 0;
    month_day = 1;
    max_day = 1;
    this.h = h;
    this.w = w;
    this.x = x;
    this.y = y;
  }
  
  Workday get_day(int day_id){
    for (int i=0; i < days.size(); i++){
      Workday d = days.get(i);
      if (d.id == day_id){
        return(d);
      }
    }
    return null;
  }
  
  void add_days(int d){
    for (int i=0; i<d; i++){
      days.add(new Workday(max_day, month_day));
      max_day++;
      month_day++;
      if (month_day > month_len){
        month_day = 1;
        month_len = (month_len == 30 ? 31 : 30);
      }
    }
  }
  
  void tick(int t){
    if (t % speed == 0){  // advance the time
      current_time++;
      if (current_time > TIME_UNITS_PER_DAY){
        current_time = 0;
        current_day++;
        println("day: "+current_day);
        if (current_day > 1){  // remove oldest, add one more
          days.remove(0);
          add_days(1);
          //println("added day, len="+days.size());
        }        
      }
    }
      
  }
  
  ArrayList<Workday> drawable_days(){
    int index = -1;
    for (int i=0; i < days.size(); i++){
      Workday e = days.get(i);
      if (e.id == current_day){
        index = i;
        break;
      }
    }

    ArrayList<Workday> day_list = new ArrayList<Workday>();
    if (index > -1) {  
      for (int i=0; i<visible_days+1; i++){
        day_list.add(days.get(index+i));
      }
    }
    return day_list; 
  }
  
  void draw(){
    int padding = 10;
    int day_width = ((w-padding)/visible_days)-padding;
    int i=0;
    float nudgex = ((t-1)%speed)*((day_width/TIME_UNITS_PER_DAY)/float(speed));
    int offsetx = (current_time) * day_width/TIME_UNITS_PER_DAY + ceil(nudgex);

    //println("current_time:"+current_time+"nudge:"+nudgex+" t:"+t+" offsetx:"+offsetx);

    for (Workday day: drawable_days()){
      pushMatrix();
      translate(x+padding+(i*(day_width+padding))-offsetx, y+padding);
      day.draw(day_width, h - padding*2);
      popMatrix();
      i++;
    }
    
    fill(#ffffff);
    noStroke();    
    rect(x-(day_width+padding), y-50, (day_width+padding), h+100);  // mask left
    rect(x+w, y-50, (day_width+padding), h+100);  // mask right
    noFill();
    stroke(#999999);
    rect(x,y,w,h);

  }
}
