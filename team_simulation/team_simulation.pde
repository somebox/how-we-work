import controlP5.*;
ControlP5 cp5;

Team team;
Sprint sprint;
Position sprint_loc;
Position team_loc;

int team_size = 4;
int speed = 10;
int t=0;
int ticks=0;
boolean paused = true;

void tick(int t) {
  if (t % 4 == 0) {
    for (Person p : team.members) {
      p.next_frame();
    }
  }
  if (t % speed == 0) {
    sprint.tick();

    // unblock people
    for (Person p : team.members) {
      p.tick();
      if (p.is_blocked()) {
        if (random(10)+3 < p._blocked_ticks) {
          p.set_active();
          p.random_frame();
        }
      }
    }

    // randomly block someone
    if (random(10) > 8) {
      Person p = team.members.get(ceil(random(team.members.size()-1)));
      if (p.is_active()) {
        p.set_blocked();
        p.random_frame();
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
  size(1920, 1080);
  frameRate(60);
  setup_ui();
  load_images();
  team = new Team();
  team.set_position(new Position(width/2-100, height/2, 100));
  sprint = new Sprint(team);
  sprint.set_position(new Position(ui_padding+100, height/4, 80));
  for (int i=0; i<team_size; i++) {
    Person p = new Engineer(new Position(i*(140), 0, 100));
    p.scale = 1.0;
    team.add_person(p);
  }
  new_sprint();
}

void draw() {
  background(255);
  if (!paused) {
    tick(t++);
  }
  team.draw();
  sprint.draw();
  cp5.get("sp_label").setStringValue(str(sprint.velocity()));
  cp5.get("sp_time").setStringValue(str(ticks));

  if (sprint.is_finished()) {
    sprint.finish();
    team_chart.push("velocity", sprint.last_log().velocity);
    debt_chart.push("tech_debt", sprint.last_log().tech_debt);
    new_sprint();
    //cp5.getController("Start").setCaptionLabel("Next Sprint");
  }
}

void new_sprint() {
  while (sprint.estimated_cost() < sprint.velocity()){
    Task task = new Task(story_points(ceil(random(5))), 1);
    task.specify();
    sprint.backlog.add(task);
    //println("added to sprint "+sprint.estimated_cost()+" < "+sprint.velocity());
  }
  cp5.getController("sp_number").setStringValue("Sprint "+sprint.sprint_number);
}
