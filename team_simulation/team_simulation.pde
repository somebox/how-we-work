

Team team;
Sprint sprint;
int team_size = 5;
int t=0;
int ticks=0;

void tick(int t){
  if (t % 30 == 0){
    ticks++;
    sprint.tick();
  }
}

void setup(){
  size(800,600);
  team = new Team();
  sprint = new Sprint(team);
  sprint.backlog.loc = new DisplayLocation(width/5, height/3, 30);
  for (int i=0; i<team_size; i++){
    Person p = new Engineer();
    p.loc = new DisplayLocation(i*40, 0, 30);
    team.add_person(p);
  }
  for (int i=0; i<8; i++){
    Task task = new Task(ceil(random(40)+1), 1);
    task.specify();
    sprint.backlog.add(task);
  }
}

void draw(){
  tick(t++);
  background(0);
  team.draw(width/2, height/2, 10);
  sprint.draw();
}
