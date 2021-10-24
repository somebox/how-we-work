static int _max_id = 0;
static abstract class State {
  static final int NOT_READY = 0;
  static final int READY = 1;
  static final int STARTED = 2;
  static final int PAUSED = 3;
  static final int DONE = 4;
}


class Activity extends Sprite {
  int age;               // total number of ticks this task has been around
  float estimated_cost;   // work points expected to finish this activity
  float _total_cost;       // total effort it took to do this activity
  int _state;            // internal state tracking
  color card_color;  
  int id;
  Person _owner;
  

  Activity(){
    super();
    _state = State.NOT_READY;
    _total_cost = 0;
    estimated_cost = 0;
    age = 0;    
    card_color = #999999;
    id = _max_id++;
  }
  
  String name(){
    return ("activity "+ id);
  }
  
  String summary(){
    return (name() + " cost:" + _total_cost + " est:" + estimated_cost + " time to deliver:" + age);
  }
  
  void specify(){  _state = State.READY;  }
  boolean is_ready(){  return(_state == State.READY);  } 
  
  void start(){  _state = State.STARTED; }
  boolean is_started(){  return (_state == State.STARTED);  }
  
  void pause(){  _state = State.PAUSED;  }
  boolean is_paused(){   return (_state == State.PAUSED);  }
  
  void finish(){  _state = State.DONE;  }
  boolean is_finished(){ return (_state == State.DONE);  }
  
  void tick(){
     age++; 
  }
  
  float total_cost(){
    return _total_cost;
  }
 
  void do_work(float work_points){
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
  
  void draw(){
    pushMatrix();
    
    // card
    noStroke();
    fill(card_color);
    translate(pos.x, pos.y);
    //rotate(random(0.1));
    rect(0, 0, pos.size, pos.size);

    // label
    textSize(pos.size/2.5);
    fill(#000000);
    text(str(estimated_cost), 2, pos.size/3);
    
    // show progress circle
    if (is_started()){
      fill(#44aa00);
      Progress p = new Progress(new Position(pos.size/2, ceil(pos.size/1.7), pos.size/2));
      p.percent = percent_done();
      p.draw();
    }
    popMatrix();
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
