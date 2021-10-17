

Team team;
Sprint sprint;
Position sprint_loc;
Position team_loc;
int team_size = 4;
int backlog_size = 12;
int t=0;
int ticks=0;

void tick(int t){
  if (t % 30 == 0){
    sprint.tick();
    
    // unblock people
    for (Person p: team.members){
      if (p.is_blocked()){
        if (random(10)+3 < p._blocked_ticks){
          p.set_active();
        }
      }
    }
    
    // randomly block someone
    if (random(10) > 8) {
      Person p = team.members.get(ceil(random(team.members.size()-1)));
      if (p.is_active()){
        p.set_blocked();
      }
    }
    
    ticks++;
  }
}

int story_points(int magnitude){
   int values[] = { 1,2,3,5,8,13,21 };
   return (values[magnitude]);
}

void setup(){
  size(800,600);
  team = new Team();
  team.set_position(new Position(width/2, height/3, 40));
  sprint = new Sprint(team);
  sprint.set_position(new Position(width/10, height/4, 40));
  for (int i=0; i<team_size; i++){
    Person p = new Engineer(new Position(i*(40+10), 0, 40));
    team.add_person(p);
  }
  for (int i=0; i < backlog_size; i++){
    Task task = new Task(story_points(ceil(random(5))), 1);
    task.specify();
    sprint.backlog.add(task);
  }
}

void draw(){  
  background(0);
  tick(t++);
  team.draw();
  sprint.draw();
  if (sprint.is_finished()){
    sprint.print_summary();
    exit();
  } 
}
