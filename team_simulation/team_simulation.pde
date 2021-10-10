

Team team;
Sprint sprint;
int team_size = 4;
int backlog_size = 12;
int t=0;
int ticks=0;

void tick(int t){
  if (t % 30 == 0){
    ticks++;
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
  }
}

int story_points(int magnitude){
   int values[] = { 1,2,3,5,8,13,21 };
   return (values[magnitude]);
}

void setup(){
  size(800,600);
  team = new Team();
  sprint = new Sprint(team);
  sprint.backlog.loc = new DisplayLocation(width/10, height/4, 40);
  for (int i=0; i<team_size; i++){
    Person p = new Engineer();
    p.loc = new DisplayLocation(i*40, 0, 40);
    team.add_person(p);
  }
  for (int i=0; i < backlog_size; i++){
    Task task = new Task(story_points(ceil(random(6))), 1);
    task.specify();
    sprint.backlog.add(task);
  }
}

void draw(){
  tick(t++);
  background(0);
  team.draw(width/2+width/10, height/2, 10);
  sprint.draw();
}
