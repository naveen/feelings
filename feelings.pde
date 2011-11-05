String baseURL = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence,gender&display=xml";
ArrayList<FeelingObject> feelingList = new ArrayList();
PFont labelFont;
PFont labelFontAlternate;

void setup() {
  size(700, 700);
  background(0);
  smooth();
  
  loadFeelings();
  
  println(PFont.list()); // list of all of the installed fonts on this machine
  labelFont = createFont("Times-Bold", 28);
  labelFontAlternate = createFont("Helvetica", 28);
  textFont(labelFont); // this is to set it once globally for all text
  textSize(18);
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
    String gender = child.getString("gender");
    if (feeling != null) {
      FeelingObject f = new FeelingObject();
      f.feeling = feeling;
      f.sentence = sentence;
      f.gender = gender;
      f.tpos.x = random(width);
      f.tpos.y = random(height);
      
      feelingList.add(f);
    }
  }
}

// sort functions
void sortScatter() {
  for(FeelingObject f:feelingList) {
    f.tpos.x = random(width);
    f.tpos.y = random(height);
  }
}

void sortByWord(String w) {
  for(FeelingObject f:feelingList) {
    if (f.feeling.equals(w)) {
      f.tpos.x = 100;
    } else {
      f.tpos.x = random(300, width);
    }

    f.tpos.y = random(height);
  }
}

void sortByGender() {
  for(FeelingObject f:feelingList) {
    if (f.gender != null) {
      if (f.gender.equals("0")) { // female
        f.tpos.x = 100;
      } else if (f.gender.equals("1")) {
        f.tpos.x = 300;
      }
    } else {
      f.tpos.x = random(500, width);
    }
    
    f.tpos.y = random(height);
  }
}

void keyPressed() {
  if (key == 'x') sortScatter();
  if (key == 'h') sortByWord("happy");
  if (key == 'b') sortByWord("better");
  if (key == 'g') sortByGender();
}
