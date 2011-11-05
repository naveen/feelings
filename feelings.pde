String baseURL = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml";
ArrayList<FeelingObject> feelingList = new ArrayList();

void setup() {
  size(700, 700);
  background(0);
  smooth();
  
  loadFeelings();
}

void draw() {
  background(0);
  
  for (FeelingObject f:feelingList) {
    f.update();
    f.render();
  }
}

void loadFeelings() {
  // load the xml
  XMLElement xml = new XMLElement(this, baseURL);
  for(int i = 0; i < xml.getChildCount(); i++) {
    XMLElement child = xml.getChild(i);
    String feeling = child.getString("feeling");
    String sentence = child.getString("sentence");
    if (feeling != null) {
      FeelingObject f = new FeelingObject();
      f.feeling = feeling;
      f.sentence = sentence;
      f.tpos.x = random(width);
      f.tpos.y = random(height);
      
      feelingList.add(f);
    }
  }
}
