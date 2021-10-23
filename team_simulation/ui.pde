int ui_top = 20;
int ui_padding = 20;
Chart team_chart;

void setup_ui(){
  cp5 = new ControlP5(this);
  PFont pfont_b = createFont("Helvetica", 36, true);
  PFont pfont_m = createFont("Helvetica", 20, true);
  PFont pfont_ui = createFont("Menlo", 14, true);
  ControlFont bigfont = new ControlFont(pfont_b);
  ControlFont medfont = new ControlFont(pfont_m); 
  ControlFont uifont = new ControlFont(pfont_ui); 
    
  cp5.addTextlabel("sp_number", "sn", ui_padding, ui_top)
    .setFont(bigfont)
    .setColor(#000000)
    .setSize(200, 130);
    
  cp5.addButton("Start")
    .setFont(uifont)
    .setPosition(200, ui_top)
    .setSize(90, 35);

  cp5.addLabel("Story Points")
    .setPosition(width - 200, ui_top)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("Story Points", medfont, 0x000000);
  
  cp5.addTextlabel("sp_label", "points", width-60, ui_top)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("sp_label", medfont, 0x000000);
  
  cp5.addLabel("Elapsed Time")
    .setPosition(width - 200, ui_top+ui_padding*2)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("Elapsed Time", medfont, 0x000000); 
  
  cp5.addTextlabel("sp_time", "time", width-60, ui_top+ui_padding*2)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("sp_time", medfont, 0x000000);
  
  // add a vertical slider
  cp5.addSlider("speed_slider")
     .setPosition(400, ui_top)
     .setSize(250,35)
     .setRange(0,50)
     .setValue(10)
     .setLabel("Speed")
     .setLabelVisible(true)
     .setDecimalPrecision(1)
     .setColorLabel(0)     
     ;
  ui_style("speed_slider", uifont, 0x000000);
  
  team_chart = cp5.addChart("performance")
    .setPosition(width-300-20-ui_padding, ui_top+100)
    .setSize(300, 100)
    .setRange(0, 160)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(2)
    .setColorCaptionLabel(color(40))
    ;
  ui_style("performance", uifont, 0x000000);
  team_chart.addDataSet("velocity");
  team_chart.setData("velocity", new float[20]);
}

void speed_slider(int v){
  float max = cp5.getController("speed_slider").getMax();
  v = ceil(max+1-v);
  println("set speed = "+v);
  speed  = v;
}

void ui_style(String name, ControlFont font, color c){
  controlP5.Controller con = cp5.getController(name);
  con.setFont(font);
  con.getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER).setPaddingX(ui_padding/2);
  con.getValueLabel().setPaddingX(ui_padding/2).setFont(font);
  con.setColorForeground(#888888);
  con.setColorBackground(#ccccff);
  con.setColorActive(#444444);
}

void Start(int value) {  
  // toggle state and button text
  Controller button = cp5.getController("Start");
  if (!paused) {
    paused = true;
    button.setCaptionLabel("Start");
  } else {
    paused = false;
    button.setCaptionLabel("Reset");
  }
}
