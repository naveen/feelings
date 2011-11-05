String baseURL = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml";

void setup() {
  size(700, 700);
  background(0);
  smooth();
  
  loadFeelings();
}

void draw() {
  
}

void loadFeelings() {
  // load the xml
  XMLElement xml = new XMLElement(this, baseURL);
  println(xml);
}
