class Backlog {
  ArrayList<Activity> items = new ArrayList<Activity>();
  DisplayLocation loc;
  int spacing;
  int age;
  
  Backlog(){
    age = 0;
    spacing = 7;
  }
  
  void tick(){
    for (Activity a: items){
      a.tick();
    }
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
  
  int estimated_cost(){
     int total = 0;
     for (Activity item: items){
       total += item.estimated_cost;
     }
     return total;
  }
  
  int velocity(){
     int total = 0;
     for (Activity item: done_items()){
       total += item.estimated_cost;
     }
     return total;
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
  
  int size(){
    return items.size();
  }
    
  ArrayList<Activity> todo_items(){
    return find_items(State.READY);
  }

  ArrayList<Activity> doing_items(){
    ArrayList<Activity> list = new ArrayList<Activity>();
    list = find_items(State.STARTED);
    list.addAll(find_items(State.PAUSED));
    return list;
  }
  
  ArrayList<Activity> done_items(){
    return find_items(State.DONE);
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
  int sprint_number;
  int age;
  
  Sprint(Team t){
    backlog = new Backlog();
    team = t;
    sprint_number = 1;
    age = 0;
  }
  
  void draw(){
    // draw sprint board
    backlog.draw_column("ToDo",  0, #999999, backlog.todo_items());
    backlog.draw_column("Doing", 2, #e6de72, backlog.doing_items());
    backlog.draw_column("Done",  4, #88ff88, backlog.done_items());
    
    // draw connections
    for (Person p: team.members){
      if (p.is_active()){
        stroke(126);
        DisplayLocation a_loc = p.current_activity.loc;
        line(p.loc.x, p.loc.y, a_loc.x + a_loc.size/2, a_loc.y + a_loc.size/2); 
      }
    }
  }
  
  boolean is_finished(){
     return (backlog.todo_items().size() == 0) && (backlog.doing_items().size() == 0); 
  }
  
  void print_summary(){
    println("Sprint "+sprint_number);
    println("  total time: "+age+" ticks");
    println("  tasks done: "+backlog.done_items().size()+"/"+backlog.size());
    println("    estimate: "+backlog.estimated_cost()+ " story points");
    // println("    velocity: "+backlog.velocity()+ " story points");
  }
  
  void tick(){
    // update tasks
    backlog.tick();
    age++;

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
