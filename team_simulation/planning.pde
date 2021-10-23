class Backlog {
  ArrayList<Activity> items = new ArrayList<Activity>();
  int age;
  
  Backlog(){
    age = 0;
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
     int t = 0;
     for (Activity item: done_items()){
       t += item.total_cost();
     }
     return t;
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
  
  boolean is_done(){
    return((todo_items().size() == 0) && (doing_items().size() == 0));
  }

}

class SprintLog {
  int number;  // sprint number
  int velocity;
  int total_time;
  int estimated_points;
  int number_tasks;
  int team_size;
  
  SprintLog(Sprint sprint){
    number = sprint.sprint_number;
    team_size = sprint.team.members.size();
    velocity = sprint.backlog.velocity();
    total_time = sprint.backlog.age;
    estimated_points = sprint.backlog.estimated_cost();
    number_tasks = sprint.backlog.items.size();
  }
}

class Sprint extends Sprite{
  Backlog backlog;
  Team team;
  int sprint_number;
  int age;
  int max_age;
  ArrayList<SprintLog> history = new ArrayList<SprintLog>();
  
  Sprint(){
    super();
  }
  
  Sprint(Team t){
    super();
    backlog = new Backlog();
    team = t;
    sprint_number = 1;
    age = 0;
    max_age=40;
  }
  
  void finish(){
    sprint.print_summary();  
    history.add(new SprintLog(sprint));
    sprint_number++;
    age = 0;
    sprint.backlog.items.clear();
  }

  SprintLog last_log(){
     return history.get(history.size()-1); 
  }

  boolean is_finished(){
     return (age > max_age) || backlog.is_done(); 
  }
  
  int velocity(){
     int total = 0;
     for (Activity item: backlog.done_items()){
       total += item.estimated_cost;
     }
     return total;
  }
  
  void print_summary(){
    println("Sprint "+sprint_number);
    println("  total time: "+age+" ticks");
    if (age > max_age){ println("   * sprint ended with unfinished work"); }
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
  
  void draw(){
    // draw sprint board
    draw_backlog_column(sprint.backlog.todo_items(),  pos, "ToDo",  0, #999999);
    draw_backlog_column(sprint.backlog.doing_items(), pos, "Doing", 2, #e6de72);
    draw_backlog_column(sprint.backlog.done_items(),  pos, "Done",  4, #88ff88);
    
    // draw connections
    for (Person p: team.members){
      if (p.is_active()){
        stroke(126);
        Position a_loc = p.current_activity.pos;
        Position p_loc = team.pos.offset(p.pos);
        line(p_loc.x, p_loc.y, a_loc.x +  a_loc.size/2, a_loc.y + a_loc.size/2); 
      }
    }
  }
}
