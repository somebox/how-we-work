class Backlog {
  ArrayList<Activity> items = new ArrayList<Activity>();
  DisplayLocation loc;
  int spacing = 7;
  
  Backlog(){
  }
  
  Activity pull(){
    for (int i=0; i<items.size(); i++){
      Activity item = items.get(i);
      if (item.is_ready()){
        return(item);
      }
    }
    return null;    
  }
  
  void add(Activity a){
    items.add(a);
  }
  
  ArrayList<Activity> find_items(int status){
     ArrayList<Activity> list = new ArrayList<Activity>();
     for (Activity item: items){
       if (item._state == status){ 
         list.add(item);
       }
     }
     return list;
  }
  
  void draw_column(String name, int column_num, color c, ArrayList<Activity> list){
    int x = loc.x + (loc.size+spacing)*column_num;
    int y = loc.y;
    int max_col_items = 6;  // max vertical items
    
    // column name
    fill(#ffffff);
    text(name, x, y-spacing*2);
    
    // draw activity cards
    for (int i=0; i < list.size(); i++){
      Activity a = list.get(i);
      // card
      noStroke();
      fill(c);
      
      int xoffset = (loc.size+spacing)*floor(i/max_col_items);
      int yoffset = (i % max_col_items)*(loc.size+spacing);
      
      a.loc = new DisplayLocation(x + xoffset, y + yoffset, loc.size);
      rect(a.loc.x, a.loc.y, a.loc.size, a.loc.size);

      // label
      textSize(loc.size/2.5);
      fill(#000000);
      text(str(a.estimated_cost), a.loc.x+2, a.loc.y+loc.size/3);
      
      // show progress circle
      if (a.is_started()){
        fill(#44aa00);
        Progress p = new Progress(new DisplayLocation(a.loc.x+loc.size/2, a.loc.y+ceil(loc.size/1.7), loc.size/2));
        p.percent = a.percent_done();
        p.draw();
      }
    }
  }
}


class Sprint {
  Backlog backlog;
  Team team;
  
  Sprint(Team t){
    backlog = new Backlog();
    team = t;
  }
  
  void draw(){
    // draw sprint board
    ArrayList<Activity> list = new ArrayList<Activity>();
    list = backlog.find_items(2);
    DisplayLocation b_loc = backlog.loc;
    list.addAll(backlog.find_items(3));
    backlog.draw_column("ToDo",  0, #999999, backlog.find_items(1));
    backlog.draw_column("Doing", 2, #e6de72, list);
    backlog.draw_column("Done",  4, #88ff88, backlog.find_items(4));
    
    // draw connections
    for (Person p: team.members){
      if (p.is_active()){
        stroke(126);
        DisplayLocation a_loc = p.current_activity.loc;
        line(p.loc.x, p.loc.y, a_loc.x + a_loc.size/2, a_loc.y + a_loc.size/2); 
      }
    }
  }
  
  void tick(){
    for (Person p: team.members){
      if (p.is_idle()){  // assign a new task
        Activity item = backlog.pull();
        if (item != null){
          //println(p.title() + " is starting " + item.name() + " status " + item._state);
          item.start();          
          p.work_on(item);
        } else {
          //println("no items in backlog");
        }
      } else {
        Activity item = p.current_activity;
        p.work(); // continue on currently assigned task
        //println(p.title() + " working on " + item.name() + " " + ceil(item.percent_done()*100) + "% done"); 
      }
    }
  }
  
}
