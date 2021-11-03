import controlP5.*;
import com.hamoid.*;  // https://github.com/hamoid/video_export_processing
/*

A visual simulation of a team working with Scrum, that shows how the team will 
gain velocity over time, and are impacted by technical debt and interruptions.

Based on experience working with tech teams, the simulation is designed in a way that
there is some small overhead associated with switching tasks, waiting on things,
meeting and discussing, and preparing for the next sprint.

This was done to help gain understanding about the interaction patterns teams
experience and to share the observations with others.


*/

ControlP5 cp5;
VideoExport videoExport;  // external lib 
static final boolean RECORD = false;

Team team;
Sprint sprint;
Position sprint_loc;
Position team_loc;

int team_size = 5;
int speed = 10;
int interruptions = 2;
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
        println("blocked person "+p+" for "+p._blocked_ticks+" ticks");
        if (random(20)+2 < p._blocked_ticks) {
          println("unblocked person "+p+" after "+p._blocked_ticks+" ticks");
          p.set_active();
          p.random_frame();
        }
      }
    }

    // randomly block someone
    if (random(100) > (interruptions)) {
      Person p = team.members.get(floor(random(team.members.size())));
      if (p.is_active()) {
        p.set_blocked();
        println("blocked person"+p);
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
  size(1200, 800);
  frameRate(60);
  videoExport = new VideoExport(this, "team.mp4");
  videoExport.setFrameRate(30); 
  if (RECORD) videoExport.startMovie();
  setup_ui();
  load_images();
  team = new Team();
  team.set_position(new Position(width/5*2, (height/3)*2, 50));
  sprint = new Sprint(team);
  sprint.set_position(new Position(width/20, height/10*3, 50));
  for (int i=0; i<team_size; i++) {
    Person p = new Engineer(new Position(i*(140), 0, 50));
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
  if (RECORD && (t % 3 == 0)) videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    if (RECORD) videoExport.endMovie();
    exit();
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
