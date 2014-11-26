import ddf.minim.*;
import ddf.minim.signals.*;
import java.awt.event.KeyEvent; 
Minim minim;
AudioOutput out;
SineWave sine;
SineWave sineCat;
SineWave sine2;
AudioSample bass;
AudioSample dog_hurt;
AudioSample dog_dead;
AudioSample sex;
AudioSample destroy;
AudioSample start;
AudioSample story;
WaveformRenderer waveform;

ArrayList<Float> music = new ArrayList();
ArrayList allMusic = new ArrayList();

ArrayList<Float> analPieceEntries = new ArrayList();
ArrayList<Float> analPieceAverage = new ArrayList();
ArrayList analMusic = new ArrayList();
ArrayList analAllMusic = new ArrayList();

ArrayList speakers = new ArrayList();
ArrayList cats = new ArrayList();

ArrayList<SineWave> theSines;

Player thePlayer = new Player();
Keyboard theKeyboard = new Keyboard();

PGraphics drawBuf;
PGraphics drawGame;
PGraphics drawBuf2;

PImage dog;
PImage dog_big;
PImage heart;
PImage cat_neutral;
PImage cat_angry;
PImage cat_happy;
PImage speaker;
PImage title;

boolean redrawing = false;
float mouseBarXResult;
float mouseBarXanalyse;

boolean dead = false;
boolean noCat = false;
int life = 3;

int currentScreen;
int yStory = -650;

int mood = 0;

int x=4;
boolean once = true;

int millis_Switch_Title = millis() + 100;
int millis_moreCats = millis() + 60000 + (int)random(40000);

int rythmGlobal = 351;


void setup() {
  size(1000, 600);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);

  waveform = new WaveformRenderer();
  // see the example Recordable >> addListener for more about this
  out.addListener(waveform);

  sine = new SineWave(0, 0.2, out.sampleRate());
  sine.portamento(200);
  out.addSignal(sine);

  bass = minim.loadSample("user.mp3", 1024);
  dog_hurt = minim.loadSample("dogWhine.wav", 1024);
  dog_dead = minim.loadSample("dogWhines2.mp3", 1024);
  sex = minim.loadSample("50.mp3", 1024);
  destroy = minim.loadSample("07.mp3", 1024);
  start = minim.loadSample("start.mp3", 1024);
  story = minim.loadSample("story.mp3", 1024);



  // dog = loadImage("dog_small.png");
  dog = loadImage("dog.png");
  dog_big = loadImage("dog_big.png");
  heart = loadImage("heart.png");
  cat_neutral = loadImage("cat_neutral.png");
  cat_angry = loadImage("cat_angry2.png");
  cat_happy = loadImage("cat_happy2.png");
  speaker = loadImage("speaker.png");
  title = loadImage("title.png");

  frameRate(120);
  frameCount_start = frameCount + rythmGlobal;
  drawBuf = createGraphics(width, height, JAVA2D);
  drawBuf2 = createGraphics(width, height, JAVA2D);
  drawGame = createGraphics(width, height, JAVA2D);

  drawBuf.beginDraw();
  drawBuf.noFill();
  drawBuf.stroke(255);
  drawBuf.rect(width/2-barLength/2, barHeight, barLength, barHeight);
  drawBuf.endDraw();
}


boolean hit;

void draw() {
  switch(currentScreen) {
  case 0: 
    drawTitle(); 
    break;
  case 1: 
    drawStory(); 
    break;
  case 2: 
    drawGame(); 
    break;
  default: 
    background(0); 
    break;
  }
}

int millis_Switch_Story = millis()+1000000;

void drawTitle() {
  if (once) {
    start.trigger(); 
    once = false;
  }

  background(0);
  image(title, 225, 80);


  if (hit) {
    textSize(30);
    fill(255);
    text("Hit SPACE to start!", 355, 490);
  }
  if (millis_Switch_Title < millis()) {
    hit = !hit;
    millis_Switch_Title = millis() + 300;
  }
  textSize(12);
  fill(200);
  text("an experimental VideoGame by Adam Rafinski", width-400-50, 550);
  text("Cats by Elysia Petras", width-284-13, 570);
  text("P3 Simulation, LMC 6310, Fall 2012", width-335-50, 590);
}



void drawStory() {
  if (once) {
    start.close();
    story.trigger(); 
    millis_Switch_Story = millis() + 6000;
    //  println("set");
    once = false;
  }
  background(0);
  fill(200+(int)random(56));

  textSize(30);
  text("In the year 2030 humanity became extinct... Yes!", 80+(int)random(x), 100+(int)random(x)); 
  text("After a brief period of silence, man’s most beloved ", 80+(int)random(x), 150+(int)random(x));
  text("animals took over the planet: Dogs and Cats! ", 80+(int)random(x), 200+(int)random(x));
  text("In 2120 they agreed not to repeat the mistakes of ", 80+(int)random(x), 250+(int)random(x));
  text("humans and to live in peace and harmony together.", 80+(int)random(x), 300+(int)random(x));
  text("And here we are now in 2130 celebrating ", 80+(int)random(x), 350+(int)random(x));
  text("the 100th Anniversary of the Extinction of Humans...", 80+(int)random(x), 400+(int)random(x));


  if (millis_Switch_Story < millis()) {
    image(dog_big, 80, 420);
    textSize(20);
    fill(255, 0, 0);
    text("You are the amazing Robo Dog, a musician", 300, 460-5);
    text("Your job is to keep the cats dancing... and populating!", 300, 490-5);
    text("Or otherwise there will be no cats anymore...", 300, 520-5);

    if (hit) {
      textSize(30);
      fill(255);
      text("Hit SPACE to start the party...", 300, 565);
    }
    if (millis_Switch_Title < millis()) {
      hit = !hit;
      millis_Switch_Title = millis() + 300;
    }
  }
}


void drawGame() {
  if (once) {
    story.close();
  }
  smooth();
  background(0);
  stroke(255);
  fill(0);

  globalBang();



  // update Speakers
  for (int i=0; i<speakers.size(); i++) {
    Speaker oneSpeaker = (Speaker)speakers.get(i);
    oneSpeaker.drawSpeaker();
  }



  // update cats
  for (int i=cats.size()-1; i>=0; i--) {
    Cat oneCat = (Cat)cats.get(i);
    if (oneCat.tooHungry()) {
      cats.remove(i);
      oneCat.catSine.setAmp(0.);
    } 
    else {

      oneCat.drawAndMove();
    }
  }

  // draw Waveform
  waveform.draw();
  noFill();
  stroke(255);

  // draw bar  
  if (barOn && barDelay == false) {
    image(drawBuf, 0, 0);
  }


  // draw life  
  if (dead == false) {  
    // draw dog
    thePlayer.update();
  } 
  else {


    if (hit) {
      textSize(30);
      fill(0, 255, 0);
      text("GAME OVER! Press \"v\" to continue...", 265, 490);
    }

    if (millis_Switch_Title < millis()) {
      hit = !hit;
      millis_Switch_Title = millis() + 300;
    }
    textSize(10);
  }

  if (millis_moreCats < millis()) {
    spawnCats(); 
    millis_moreCats = millis() + 60000 + (int)random(40000);
  }

  if (dead == false) {   
    bar();
  }

  catCheck();

  for (int i=0; i<life; i++) {
    image(heart, 10+35*i, 20);
  }

  frame.setTitle(int(frameRate) + " fps");
}


void globalBang() {
  // global bang
  if ( frameCount_start > frameCount-2 && frameCount_start < frameCount+2 ) {
    background(255);
  } 

  if ( frameCount_start < frameCount ) {
    frameCount_start = frameCount + rythmGlobal; 
    bass.trigger(); 

    for (int i=0; i<speakers.size(); i++) {
      Speaker oneSpeaker = (Speaker)speakers.get(i);
      oneSpeaker.reset();
    }

    for (int i=cats.size()-1; i>=0; i--) {
      Cat oneCat = (Cat)cats.get(i);
      oneCat.reset();
    }
  }
}


void mousePressed() {
  if (barOff) {
    barOn = true;
    barStart = frameCount + 1.5 * rythmGlobal;
    barStartDelay2 = frameCount + rythmGlobal/4;
    barStartDelay1 = frameCount + rythmGlobal/2;
    speakerX = mouseX;
    speakerY = mouseY;
  }
}

void mouseDragged() {
  drawLine = true;
}

void mouseReleased() {
  // barOn = false;
  drawLine = false;
}


void keyReleased(KeyEvent evt) {
  theKeyboard.modifyKey( evt.getKeyCode(), false );

//  if (key == KeyEvent.VK_SPACE) {
//  }
}

void keyPressed(KeyEvent evt) {
  theKeyboard.modifyKey( evt.getKeyCode(), true );


  if (key == '1') {
    mood = 0;
  }

  if (key == '2') {
    mood = 1;
  }

  if (key == '3') {
    mood = 2;
  }

  if (key == '4') {
    mood = 3;
  }                

  if (key == '5') {
    mood = 4;
  }

  if (key == '6') {
    mood = 5;
  }

  if (key == '7') {
    mood = 6;
  }

  if (key == '8') {
    mood = 7;
  }

  if (key == 'v') {
    if (dead) {
      life = 3;
      dead = false;
      thePlayer.playerX = width/2;
      thePlayer.playerY = 500;
    }
  }
}


void stop()
{

  bass.close();
  dog_hurt.close();
  dog_dead.close();
  sex.close();
  destroy.close();
  start.close();
  story.close();
  // always stop Minim before exiting
  minim.stop();

  super.stop();
}

void catCheck() {
  if (cats.size() == 0) {
    if (hit) {
      textSize(30);
      fill(255);
      text("Hit \"c\" to spawn new cats!", 355, 490);
    }

    if (millis_Switch_Title < millis()) {
      hit = !hit;
      millis_Switch_Title = millis() + 300;
    } 
    noCat = true;
  } 
  else {
    noCat = false;
  }


  if (cats.size() == 1) {
    sineCat = new SineWave(0, 0.5, out.sampleRate());
    sineCat.portamento(catSpeakCharacter);
    out.addSignal(sineCat);

    int tastRandom1 = (int)random(6);


    cats.add( new Cat((int)random(1000), (int)random(600), tastRandom1, sineCat) );

    int tastRandom2 = (int)random(6);


    if (tastRandom1 == tastRandom2) {
      int tastTemp = tastRandom1-1;
      if (tastTemp >=0) {

        cats.add( new Cat(mouseX, mouseY, tastTemp, sineCat) );
      } 
      else {
        int tastTemp2 = tastRandom1+1;
        cats.add( new Cat((int)random(1000), (int)random(600), tastTemp2, sineCat) );
      }
    } 
    else {
      cats.add( new Cat((int)random(1000), (int)random(600), tastRandom2, sineCat) );
    }


    for (int i=cats.size()-1; i>=0; i--) {
      Cat oneCat = (Cat)cats.get(i);
      oneCat.reset();
    }
  }
}


void spawnCats() {
  i = 0;      
  sineCat = new SineWave(0, 0.5, out.sampleRate());
  sineCat.portamento(catSpeakCharacter);
  out.addSignal(sineCat);

  int tastRandom1 = (int)random(6);


  cats.add( new Cat(mouseX, mouseY, tastRandom1, sineCat) );

  int tastRandom2 = (int)random(6);


  if (tastRandom1 == tastRandom2) {
    int tastTemp = tastRandom1-1;
    if (tastTemp >=0) {

      cats.add( new Cat((int)random(1000), (int)random(600), tastTemp, sineCat) );
    } 
    else {
      int tastTemp2 = tastRandom1+1;
      cats.add( new Cat((int)random(1000), (int)random(600), tastTemp2, sineCat) );
    }
  } 
  else {
    cats.add( new Cat((int)random(1000), (int)random(600), tastRandom2, sineCat) );
  }

  for (int i=cats.size()-1; i>=0; i--) {
    Cat oneCat = (Cat)cats.get(i);
    oneCat.reset();
  }
}

