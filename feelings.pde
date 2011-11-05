String baseURL = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence,gender&display=xml"; //&city=brooklyn
ArrayList<FeelingObject> feelingList = new ArrayList();

HashMap<String, FeelingType> feelingHash = new HashMap();
ArrayList<FeelingType> feelingTypeList = new ArrayList();

PFont labelFont;
PFont labelFontAlternate;

float maxWidth;
float offset = 0;
float toffset = 0;

void setup() {
  size(700, 700);
  background(0);
  smooth();
  
  colorMode(HSB);
  
  maxWidth = width;
  loadFeelings();
  /*
  println(feelingHash.get("good").count);
  println(feelingHash.get("good").feelingList.get(1).sentence);
  println(feelingTypeList.get(0).name);
  */
  
//  println(PFont.list()); // list of all of the installed fonts on this machine
  labelFont = createFont("Helvetica", 14);
  labelFontAlternate = createFont("Helvetica", 14);
  textFont(labelFont); // this is to set it once globally for all text
  textSize(14);
}

void draw() {
  background(0);
  
  // easing function for horizontal scroll
  offset += (toffset - offset) * 0.1;
  
  float slideWidth = maxWidth - width;
  toffset = map(mouseX, 0, width, 0, -slideWidth);
  translate(offset, 0);
  
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
      
      // do we have a feelingtype for this feeling?
      if (feelingHash.containsKey(feeling)) {
        FeelingType ft = feelingHash.get(feeling);
        ft.count++;
        ft.feelingList.add(f);
        f.c = ft.c;
      } else {
        // make a new feelingType
        FeelingType ft = new FeelingType();
        ft.name = feeling;
        ft.count = 1;
        ft.feelingList.add(f);
        ft.c = f.c = color(random(255), 255, 255);
        
        // add it to the hash
        feelingHash.put(feeling, ft);
        
        // add it to the list
        feelingTypeList.add(ft);
      }
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

void sortAsGraph() {
  float xpos = 0;
  
  for(int i = 0; i < feelingTypeList.size(); i++) {
    FeelingType ft = feelingTypeList.get(i);

    for (int j = 0; j < ft.feelingList.size(); j++) {
      FeelingObject fo = ft.feelingList.get(j);
      fo.tpos.x = xpos;
      fo.tpos.y = 400 + j * -10;
    }
    
    float w = textWidth(ft.name);
    xpos += w + 5;
  }
  
  maxWidth = xpos;
}

void keyPressed() {
  maxWidth = width;
  
  if (key == 'x') sortScatter();
  if (key == 'h') sortByWord("happy");
  if (key == 'b') sortByWord("better");
  if (key == 'g') sortByGender();
  if (key == 'l') sortAsGraph();
}
