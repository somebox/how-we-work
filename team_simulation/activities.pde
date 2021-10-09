static int _max_id = 0;

class Activity {
  DisplayLocation loc;
  int age;               // total number of ticks this task has been around
  int estimated_cost;   // work points expected to finish this activity
  int _total_cost;       // total effort it took to do this activity
  int _state;            // internal state tracking
  int id;
  Person _owner;

  Activity(){
    _state = 0;
    _total_cost = 0;
    estimated_cost = 0;
    age = 0;    
    id = _max_id++;
  }
  
  String name(){
    return ("activity "+ id);
  }
  
  void specify(){  _state = 1;  }
  boolean is_ready(){  return(_state == 1);  } 
  
  void start(){  _state = 2; }
  boolean is_started(){  return (_state == 2);  }
  
  void pause(){  _state = 3;  }
  boolean is_paused(){   return (_state == 3);  }
  
  void finish(){  _state = 4;  }
  boolean is_finished(){ return (_state == 4);  }
  
  void tick(){
     age++; 
  }
 
  void do_work(Person p, int work_points){
    _total_cost += work_points;
    if (_total_cost > estimated_cost){
      this.finish();
    }
  }

  float percent_done(){
    return(_total_cost/(float)estimated_cost);
  }

}

class Meeting extends Activity {
  Meeting(int cost_est){
    super();
    this.estimated_cost = cost_est;
  }
}


class Task extends Activity {
  int complexity;        // 0-10, 0 takes no time to do (only to plan). 10 is the highest.
  int overhead;          // "tax" on work required due to constraints, work points added that make this activ harder  
  int quality;           // 0-10, 0 is total failure, 10 is bug-free. quality impacts business_value and operational_effort;

  ArrayList<Task> dependencies = new ArrayList<Task>();
  
  String name(){
    return ("task "+ id);
  }

  Task(int cost, int points){
    super();
    estimated_cost = cost;
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
