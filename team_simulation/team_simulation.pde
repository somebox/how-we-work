import controlP5.*;
ControlP5 cp5;



Team team;
Sprint sprint;
Position sprint_loc;
Position team_loc;
int team_size = 4;
int backlog_size = 12;
int t=0;
int ticks=0;
boolean paused = true;

Textlabel vel_label;

void tick(int t) {
  if (t % 30 == 0) {
    sprint.tick();

    // unblock people
    for (Person p : team.members) {
      if (p.is_blocked()) {
        if (random(10)+3 < p._blocked_ticks) {
          p.set_active();
        }
      }
    }

    // randomly block someone
    if (random(10) > 8) {
      Person p = team.members.get(ceil(random(team.members.size()-1)));
      if (p.is_active()) {
        p.set_blocked();
      }
    }

    ticks++;
  }
}

int story_points(int magnitude) {
  int values[] = { 1, 2, 3, 5, 8, 13, 21 };
  return (values[magnitude]);
}

void setup() {
  size(800, 600);
  cp5 = new ControlP5(this);
  PFont pfont = createFont("Arial", 20, true);
  ControlFont bigfont = new ControlFont(pfont, 36);
  ControlFont medfont = new ControlFont(pfont, 20);

  cp5.addTextlabel("sp_number", "sn", 10, 10)
    .setFont(bigfont)
    .setSize(200, 130);
  cp5.addButton("Start")
    .setPosition(160, 20)
    .setSize(60, 25);
  cp5.addLabel("Story Points")
    .setPosition(width - 200, 20)
    .setFont(medfont)
    .setSize(200, 130);
  cp5.addTextlabel("sp_label", "points", width-60, 20)
    .setFont(medfont)
    .setSize(200, 130);
  cp5.addLabel("Elapsed Time")
    .setPosition(width - 200, 50)
    .setFont(medfont)
    .setSize(200, 130);
  cp5.addTextlabel("sp_time", "time", width-60, 50)
    .setFont(medfont)
    .setSize(200, 130);
    
  team = new Team();
  team.set_position(new Position(width/2, height/3, 40));
  sprint = new Sprint(team);
  sprint.set_position(new Position(width/10, height/4, 40));
  for (int i=0; i<team_size; i++) {
    Person p = new Engineer(new Position(i*(40+10), 0, 40));
    team.add_person(p);
  }
  fill_backlog();
}

void fill_backlog(){
  for (int i=0; i < backlog_size; i++) {
    Task task = new Task(story_points(ceil(random(5))), 1);
    task.specify();
    sprint.backlog.add(task);
  }
  cp5.getController("sp_number").setStringValue("Sprint "+sprint.sprint_number);
}

void Start(int value) {
  Controller label = cp5.getController("sp_number");
  if (sprint.is_finished()){
    println("sprint finished");
    sprint.reset();
    fill_backlog();
    paused = true; // forcing toggle below, which will auto-start
  }
  
  // toggle state and button text
  Controller button = cp5.getController("Start");
  if (!paused) {
    paused = true;
    button.setCaptionLabel("Start");
  } else {
    paused = false;
    button.setCaptionLabel("Stop");
  }
}


void draw() {
  background(0);
  if (!paused) {
    tick(t++);
  }
  team.draw();
  sprint.draw();
  cp5.get("sp_label").setStringValue(str(sprint.velocity()));
  cp5.get("sp_time").setStringValue(str(ticks));

  if (sprint.is_finished() && !paused) {
    sprint.print_summary();
    paused = true;
    cp5.getController("Start").setCaptionLabel("Next Sprint");
  }
}
