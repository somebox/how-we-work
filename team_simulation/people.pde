
class Person extends Animation {
  int skill_level = 0;       // 0-10, with 0 being unable to do tasks, 1=junior, 3-5=typical, 6=senior, 8=expert, 10=principal
  int _status = 0;           // 0 = idle, 1=active, 2=blocked'
  int _blocked_ticks = 0;
  Activity current_activity;
  String status_animations[] = {"person/person-idle", "person/person-typing", "person/person-talking"};
  
  Person(){
    super();
    set_image_sequence();
  }
  
  Person(Position p){
    this();
    set_position(p);
  }
    
  String title(){
    return "employee";
  }
  
  void tick(){
    if (is_blocked()){
      _blocked_ticks++;
    }
  }
  
  void set_image_sequence(){
    image_sequence = image_library.get(status_animations[_status]);
  }
  
  void work_on(Activity activity, float points){
    current_activity = activity;
    set_active();
    activity.do_work(points);
    if (activity.is_finished()){
      set_idle();
      current_activity = null;
      //println(title() + " finished "+activity.summary());
    }
  }
  
  //void work(){
  //  if (is_blocked()){
  //    _blocked_ticks++;
  //    return; 
  //  }
    
  //  if (current_activity != null){      
  //    work_on(current_activity);
  //  }
  //}
  
  void set_idle(){
    _status = 0;
    set_image_sequence();
  }
  boolean is_idle(){
    return (_status == 0);
  }
  void set_active(){ 
    _status = 1;
    set_image_sequence();
  }
  boolean is_active(){
    return (_status == 1);
  }
  void set_blocked(){
    _blocked_ticks = 0;
    _status = 2; 
    set_image_sequence();
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

  void draw(){
    frame = (frame) % image_sequence.frame_count;
    super.draw();
    if (current_activity != null){
      fill(#ffffff);
      text(current_activity._total_cost, pos.x, pos.y+pos.size);
    }
  }
}

class Engineer extends Person {
  Engineer(Position p){
    super(p);
  }
  
  String title() {
    return "engineer";
  }
}

class Team extends Sprite {
  ArrayList<Person> members = new ArrayList<Person>();
  
  Team() {
    super();
  }
    
  void add_person(Person p){
    members.add(p);  
  }
    
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y);
    for (Person p : team.members){
      p.draw();
    }
    popMatrix();
  }

}
