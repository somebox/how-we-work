int ui_top = 20;
int ui_padding = 20;
Chart team_chart;
Chart debt_chart;

void setup_ui(){
  cp5 = new ControlP5(this);
  PFont pfont_big = createFont("Helvetica", 32, true);
  PFont pfont_med = createFont("Helvetica", 24, true);
  PFont pfont_ui_title = createFont("Menlo", 18, true);
  PFont pfont_ui_data = createFont("Menlo", 14, true);
  ControlFont big_text = new ControlFont(pfont_big);
  ControlFont med_text = new ControlFont(pfont_med); 
  ControlFont ui_label = new ControlFont(pfont_ui_title);
  ControlFont ui_data  = new ControlFont(pfont_ui_data);
    
  cp5.addTextlabel("sp_number", "sn", ui_padding, ui_top)
    .setFont(big_text)
    .setColor(#000000)
    .setSize(200, 130);
    
  cp5.addButton("Start")
    .setFont(ui_data)
    .setPosition(180, ui_top)
    .setSize(90, 35);

  cp5.addLabel("Story Points")
    .setPosition(width - 350, ui_top)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("Story Points", med_text, 0x000000);
  
  cp5.addTextlabel("sp_label", "points", width-120, ui_top)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("sp_label", med_text, 0x000000);
  
  cp5.addLabel("Elapsed Time")
    .setPosition(width - 350, ui_top+ui_padding*2)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("Elapsed Time", med_text, 0x000000); 
  
  cp5.addTextlabel("sp_time", "time", width-120, ui_top+ui_padding*2)
    .setColor(#000000)
    .setSize(200, 130);
  ui_style("sp_time", med_text, 0x000000);

    
  int slider_size = 20;
  
  // add a vertical slider
  cp5.addSlider("speed_slider")
     .setPosition(width/10*4, ui_top)
     .setSize(250,slider_size)
     .setRange(0,50)
     .setValue(10)
     .setLabel("Speed")
     .setLabelVisible(true)
     .setDecimalPrecision(1)
     .setColorLabel(0)     
     ;
  ui_style("speed_slider", ui_label, 0x000000);
  
  team_chart = cp5.addChart("performance")
    .setPosition(width-300-20-ui_padding, ui_top+100)
    .setSize(300, 100)
    .setRange(0, 160)
    .setLabel("Velocity")
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(2)
    .setColorCaptionLabel(color(40))
    ;
  ui_style("performance", ui_label, 0x000000);
  team_chart.addDataSet("velocity");
  team_chart.setData("velocity", new float[20]);

    // add a vertical slider
  cp5.addSlider("debt_slider")
     .setPosition(width/10*4, ui_top+slider_size*1.5)
     .setSize(250,slider_size)
     .setRange(0,100)
     .setValue(10)
     .setLabel("Tech Debt")
     .setLabelVisible(true)
     .setDecimalPrecision(1)
     .setColorLabel(0)     
     ;
  ui_style("debt_slider", ui_label, 0x000000);
  
    // add a vertical slider
  cp5.addSlider("interruptions_slider")
     .setPosition(width/10*4, ui_top+(slider_size*3))
     .setSize(250,slider_size)
     .setRange(0,100)
     .setValue(10)
     .setLabel("Interruptions")
     .setLabelVisible(true)
     .setDecimalPrecision(1)
     .setColorLabel(0)     
     ;
  ui_style("interruptions_slider", ui_label, 0x000000);  
  
  debt_chart = cp5.addChart("tech_debt")
    .setPosition(width-300-20-ui_padding, ui_top+220)
    .setSize(300, 100)
    .setRange(0, 160)
    .setLabel("Complexity")
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(2)
    .setColorCaptionLabel(color(40))
    ;
  ui_style("tech_debt", ui_label, 0x000000);
  debt_chart.addDataSet("tech_debt");
  debt_chart.setData("tech_debt", new float[20]);
 
}

void speed_slider(int v){
  float max = cp5.getController("speed_slider").getMax();
  v = ceil(max+1-v);
  println("set speed = "+v);
  speed  = v;
}

void interruptions_slider(int v){
  float max = cp5.getController("interruptions_slider").getMax();
  v = ceil(max+1-v);
  println("set interruptions = "+v);
  interruptions  = v;
}

void debt_slider(int v){
  println("set tech debt = "+v);
  if (sprint != null) { sprint.tech_debt = v; }
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
