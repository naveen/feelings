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
  for(int i = 0; i < xml.getChildCount(); i++) {
    XMLElement child = xml.getChild(i);
    String feeling = child.getString("feeling");
    String sentence = child.getString("sentence");
    if (feeling != null) text(sentence, random(width), random(height));
  }
}
