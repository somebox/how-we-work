int ui_top = 20;
int ui_padding = 20;
ControlP5 cp5;
 
void setup_ui(){
  cp5 = new ControlP5(this);
  PFont pfont_big = createFont("Helvetica", 38, true);
  PFont pfont_med = createFont("Helvetica", 26, true);
  PFont pfont_ui_title = createFont("Menlo", 26, true);
  PFont pfont_ui_data = createFont("Menlo", 14, true);
  ControlFont big_text = new ControlFont(pfont_big);
  ControlFont med_text = new ControlFont(pfont_med); 
  ControlFont ui_label = new ControlFont(pfont_ui_title);
  ControlFont ui_data  = new ControlFont(pfont_ui_data);
    
  cp5.addTextlabel("sp_number", "sn", ui_padding, ui_top)
    .setFont(big_text)
    .setColor(#000000)
    .setSize(200, 130);
}
