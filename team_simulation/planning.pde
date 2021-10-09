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
    int i=0;
    int x = loc.x + (loc.size+spacing)*column_num;
    int y = loc.y;
    
    // column name
    fill(#ffffff);
    text(name, x, y-spacing*2);
    
    // draw activity cards
    for (Activity a: list){
      // card
      noStroke();
      fill(c);
      a.loc = new DisplayLocation(x, y+i*(loc.size+spacing), loc.size);
      rect(a.loc.x, a.loc.y, loc.size, loc.size);

      // label
      textSize(12);
      fill(#000000);
      text(str(a.estimated_cost), x+2, y+i*(loc.size+spacing)+10);
      
      // show progress circle
      fill(#44aa00);
      Progress p = new Progress(new DisplayLocation(x+15, y+i*(loc.size+spacing)+ceil(loc.size/1.7), 15));
      p.percent = a.percent_done();
      p.draw();
      i++;
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
    backlog.draw_column("Doing", 1, #e6de72, list);
    backlog.draw_column("Done",  2, #88ff88, backlog.find_items(4));
    
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
