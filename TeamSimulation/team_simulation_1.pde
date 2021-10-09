
class Team {
  ArrayList<Person> members = new ArrayList<Person>();
  
  void add_person(Person p){
    members.add(p);
  }
}

class Sprint {
  ArrayList<Activity> backlog = new ArrayList<Activity>(); 
}

class Activity {
  int age;               // total number of ticks this task has been around
  int _total_cost;        // total effort it took to do this task
  int _state;            // internal state tracking
  int _owner;

  Activity(){
    age = 0;    
    _total_cost = 0;
    _state = 0;
  }

  void tick(){
     age++; 
  }
  
  void specify(){  _state = 1;  }
  boolean is_specified(){  return(_state > 0);  } 
  
  void start(){  _state = 2; }
  boolean is_started(){  return (_state == 2);  }
  
  void pause(){  _state = 3;  }
  boolean is_paused(){   return (_state == 3);  }
  
  void finish(){  _state = 4;  }
  boolean is_finished(){ return (_state == 4);  }
  
  void do_work(Person p, int work_points){
    _total_cost += work_points;
  }
  
}

class Task extends Activity {
  int complexity;        // 0-10, 0 takes no time to do (only to plan). 10 is the highest.
  int quality;           // 0-10, 0 is total failure, 10 is bug-free. quality impacts business_value and operational_effort;
  int _estimated_cost;

  
  ArrayList<Task> dependencies = new ArrayList<Task>();
  
  Task(int cost, int points){
    super();
    _estimated_cost = cost;
    complexity = points;
  }
  
}

class Story extends Activity {
  int urgency;           // 0-10, 0 has no urgency, 10 is critically important
  int business_value;    // 0-10, business value, with 10 being the best
  int operational_cost;  // over the lifespan, the recurring cost per tick to maintain this feature   

  Story(int urgency_value, int biz_value) {
    super();
    urgency = urgency_value;
    business_value = biz_value;
  }
}

class Meeting extends Activity {
  Meeting(int cost_est){
    super();
  }
}

class Person {
  String title(){
    return "employee";
  }
}

class Engineer extends Person {
  String title() {
    return "engineer";
  }
}



void setup(){
  size(800,600);
}

void draw(){
  background(0);
}
