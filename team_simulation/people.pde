
class Person {
  DisplayLocation loc;
  int skill_level = 0;       // 0-10, with 0 being unable to do tasks, 1=junior, 3-5=typical, 6=senior, 8=expert, 10=principal
  int _status = 0;           // 0 = idle, 1=active, 2=blocked'
  int _blocked_ticks = 0;
  Activity current_activity;
    
  String title(){
    return "employee";
  }
  
  void work_on(Activity activity){
    current_activity = activity;
    _status = 1;
    activity.do_work(this, 1);
    if (activity.is_finished()){
      _status = 0;
      current_activity = null;
      println(title() + " finished "+activity.name());
    }
  }
  
  void work(){
    if (is_blocked()){
      _blocked_ticks++;
      return; 
    }
    
    if (current_activity != null){      
      work_on(current_activity);
    }
  }
  
  boolean is_idle(){
    return (_status == 0);
  }
  void set_active(){ _status = 1; }
  boolean is_active(){
    return (_status == 1);
  }
  void set_blocked(){
    _blocked_ticks = 0;
    _status = 2; 
  }
  boolean is_blocked(){
    return (_status == 2);
  }
  color status_color(){
    switch(_status){
      case 0: return(#888888);
      case 1: return(#88ff88);
      case 2: return(#ff3333);
      default: return(#000000);
    }
  }
  
  void draw(int x, int y){
    loc.x = x;
    loc.y = y;
    fill(status_color());
    circle(loc.x, loc.y, loc.size); 
    if (current_activity != null){
      fill(#ffffff);
      text(current_activity._total_cost, loc.x, loc.y+loc.size);
    }
  }
}

class Engineer extends Person {
  String title() {
    return "engineer";
  }
}

class Team {
  ArrayList<Person> members = new ArrayList<Person>();
  
  Team() {
  }
    
  void add_person(Person p){
    members.add(p);  
  }
  
  void draw(int x, int y, int spacing){
    int i=0;
    for (Person p : members){
      p.draw(x+p.loc.size*i+spacing*i, y);
      i++;
    }
  }
}
