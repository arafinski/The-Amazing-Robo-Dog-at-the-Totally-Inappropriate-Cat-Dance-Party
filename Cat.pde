class Cat {
  float posX, posY;
  float angle, speed;

  float distToNearestBuddy = 10000.0;

  int millis_TimeToLife;
  int millis_NextDance;
  float millis_NextRethink;
  int millis_WaitTillCheckTaste;
  int millis_wait;

  int myMood;
  
  int angry;
  
  float will;

  final int MOOD_STANDING = 0;

  final int MOOD_WANDERING = 1;
  final int MOOD_WANDERING_SEEK_BUDDY = 2;

  final int MOOD_WANDER_CURIOUS = 3;

  final int MOOD_DANCING = 4;
  final int MOOD_DANCING_SEEK_BUDDY = 5;

  final int MOOD_ATTACK_SPEAKER = 6;
  final int MOOD_ATTACK_DOG = 7;

  final int MOOD_RUN_FROM_USER = 9;

  int i;
  int beat = 87;

  ArrayList music = new ArrayList();
  ArrayList<Float> pieceEntries = new ArrayList();
  ArrayList<Float> pieceAverage = new ArrayList();

  ArrayList<Float> myMusic = new ArrayList();

  float entries;
  float average;

  int likeBeat = 0;


  Cat myBuddy = null;

  SineWave catSine;



  int catRadius = (int) random(100, 200);
  ;
  float val = 0.1;
  float myTone;
  boolean soundOn = false;

  int anger;


  float[] tasteEntries = new float[4];
  float[] tasteAverage = new float[4];

  int myTaste;






  // constructor
  Cat(float tempPosX, float tempPosY, int tempTaste, SineWave tempSine) {
    posX = tempPosX;
    posY = tempPosY;
    catSine = tempSine;
    myTaste = tempTaste;
    angry = 1+(int)random(3);
    will = (float)random(1)+1;
    checkTaste();
    genMusic();
    angle = random(0.0, TWO_PI);
    speed = random(0.5, 1.3);
    millis_NextRethink = millis() + 1000;
    myMood = MOOD_STANDING;
    millis_TimeToLife = millis() + 40000 + (int)random(20000);
    millis_WaitTillCheckTaste = millis() + 2000;
    millis_wait = millis() + 6000;
    
  }



  void checkTaste() {

    if (myTaste == 0) {
      tasteEntries[0] = 33;
      tasteEntries[1] = 66;
      tasteEntries[2] = 33;
      tasteEntries[3] = 66;

      tasteAverage[0] = 0;
      tasteAverage[1] = 1500;
      tasteAverage[2] = 0;
      tasteAverage[3] = 1500;
    }

    else if (myTaste == 1) {
      tasteEntries[0] = 33;
      tasteEntries[1] = 66;
      tasteEntries[2] = 33;
      tasteEntries[3] = 66;

      tasteAverage[0] = 0;
      tasteAverage[1] = 3000;
      tasteAverage[2] = 0;
      tasteAverage[3] = 3000;
    }

    else  if (myTaste == 2) {
      tasteEntries[0] = 33;
      tasteEntries[1] = 66;
      tasteEntries[2] = 33;
      tasteEntries[3] = 66;

      tasteAverage[0] = 0;
      tasteAverage[1] = 4500;
      tasteAverage[2] = 0;
      tasteAverage[3] = 4500;
    }

    else if (myTaste == 3) {
      tasteEntries[0] = 66;
      tasteEntries[1] = 33;
      tasteEntries[2] = 66;
      tasteEntries[3] = 33;

      tasteAverage[0] = 1500;
      tasteAverage[1] = 0;
      tasteAverage[2] = 1500;
      tasteAverage[3] = 0;
    }

    else if (myTaste == 4) {
      tasteEntries[0] = 66;
      tasteEntries[1] = 33;
      tasteEntries[2] = 66;
      tasteEntries[3] = 33;

      tasteAverage[0] = 3000;
      tasteAverage[1] = 0;
      tasteAverage[2] = 3000;
      tasteAverage[3] = 0;
    }

    else if (myTaste == 5) {
      tasteEntries[0] = 66;
      tasteEntries[1] = 33;
      tasteEntries[2] = 66;
      tasteEntries[3] = 33;

      tasteAverage[0] = 4500;
      tasteAverage[1] = 0;
      tasteAverage[2] = 4500;
      tasteAverage[3] = 0;
    }
  }


  void genMusic() {
    int fillInSpot = 0;
    for (int quarters=1;quarters<5;quarters++) {
      int startQuarterAt = 88*quarters;
      for (;fillInSpot<startQuarterAt;fillInSpot++) {

        myMusic.add( tasteAverage[quarters-1] ); // some number, higher

        if (fillInSpot>351) {

          break;
        }
      }
    }
  }


  void AI() {

    if ( dist(mouseX, mouseY, posX, posY) < 50.0 ) {
      myMood = MOOD_RUN_FROM_USER;
      millis_NextRethink = millis() + 600;
    }


    for (int i=0; i<speakers.size(); i++) {
      Speaker oneSpeaker = (Speaker)speakers.get(i);
      if (oneSpeaker.soundCheck((int)posX, (int)posY)) {
        if (myMood == MOOD_DANCING) {
          if (millis_NextDance < millis()) {
            if ((int)random(10) > 3) {

              myMood = MOOD_DANCING_SEEK_BUDDY;
              millis_NextDance = millis() + 3000+(int)random(4000);
            }
          }
        }
      }
    }

    if (likeBeat <= -20) {
      println("dislike Music");
      myMood = MOOD_ATTACK_SPEAKER;
      likeBeat = 0;
      //    println(likeBeat);
      millis_NextRethink = millis() + 2000;
      anger++;
      //    println("anger: " + anger);
    } 
    if (likeBeat >= 20) {
      println("like Music");
      myMood = MOOD_DANCING_SEEK_BUDDY;
      millis_NextRethink = millis() + 4000;
      likeBeat = 0;
      //   println(likeBeat);
    }
    
    if (likeBeat >= 10) {
      println("like Music");
      myMood = MOOD_DANCING;
      millis_NextRethink = millis() + 2000+(int)random(3000);
      likeBeat = 0;
      //   println(likeBeat);
    }


    if (anger > angry) {
      myMood = MOOD_ATTACK_DOG;
      millis_NextRethink = millis() + 10000*will + (int)random(20000);
      anger = 0;
    } 

    if (millis_NextRethink < millis()) {
      millis_NextRethink = millis() + (int)random(500, 20); // WTF MATE?
      //      println("Next Rethink" + millis_NextRethink);
      float baseBehaviorOn = random(0, 10);

      if (baseBehaviorOn < 4.) {
        myMood = MOOD_STANDING;
        millis_NextRethink = millis() + 2500+(int)random(500);
      } 

      else if (baseBehaviorOn <  6.) {
        myMood = MOOD_WANDERING;
        millis_NextRethink = millis() + 1000+(int)random(4000);
      } 

      else if (baseBehaviorOn < 8.) {
        myMood = MOOD_WANDER_CURIOUS;
        millis_NextRethink = millis() + 2000+(int)random(3000);
      } 

      else if (baseBehaviorOn > 8.) {
        myMood = MOOD_WANDERING_SEEK_BUDDY;
        millis_NextRethink = millis() + 2000;
        myBuddy = null;
        float distToNearestBuddy = 10000.0;
        for (int i=0; i<cats.size(); i++) {
          Cat oneCat = (Cat)cats.get(i);
          if ( oneCat != this && dist(oneCat.posX, oneCat.posY, posX, posY) < distToNearestBuddy ) {
            distToNearestBuddy = dist(oneCat.posX, oneCat.posY, posX, posY);
            myBuddy = oneCat;
          } // end of if (dist closer)
        } // end of for (agents.size()
      }
    } // end of millis() updating AI mood


    if (control) {
      checkControl();
    }




    switch(myMood) {

    case MOOD_STANDING:
      speed = 0.0;
      break;

    case MOOD_WANDERING:
      speed = 2.4;
      break;

    case MOOD_WANDERING_SEEK_BUDDY:

      myBuddy = null;
      distToNearestBuddy = 400.0;
      speed = 1.2*will;
      for (int i=0; i<cats.size(); i++) {
        Cat oneCat = (Cat)cats.get(i);
        if ( oneCat != this && dist(oneCat.posX, oneCat.posY, posX, posY) < distToNearestBuddy ) {
          distToNearestBuddy = dist(oneCat.posX, oneCat.posY, posX, posY);
          myBuddy = oneCat;
        }
      }

      if (myBuddy != null) {
        angle = atan2(myBuddy.posY-posY, myBuddy.posX-posX);
        speed = 1.2*will;
        if ( dist(myBuddy.posX, myBuddy.posY, posX, posY) < 5.0) {
          myBuddy.myMood = MOOD_DANCING;
          myMood = MOOD_DANCING;
          myBuddy.millis_NextRethink = millis() + 1000;
          millis_NextRethink = millis() + 1000;
          // SEX
          if ((int)random(10) > 8) {

            if (millis_wait < millis()) {

              millis_wait = millis() + 6000;
              sex.trigger(); 
              cats.add( new Cat(myBuddy.posX, myBuddy.posY, myTaste, sineCat) );
            }
          }
        }
      } 
      else {
        myMood = MOOD_WANDERING;
        speed = 1.2;
      }
      break;

    case MOOD_WANDER_CURIOUS:
      speed = 1.2;
      for (int i=speakers.size()-1; i>=0; i--) {
        Speaker oneSpeaker = (Speaker)speakers.get(i);
        if (dist(oneSpeaker.speakerX, oneSpeaker.speakerY, posX, posY) < oneSpeaker.mouseVolSave+50) {
          angle = atan2(oneSpeaker.speakerY-posY, oneSpeaker.speakerX-posX);
          speed = 1.2;
        }
      }
      break;

    case MOOD_DANCING:
      speed = 2.6*will;
      angle += 2.0*will;
      break;

    case MOOD_DANCING_SEEK_BUDDY:
      speed = 2.6*will;
      myBuddy = null;
      distToNearestBuddy = 10000.0;


      for (int i=0; i<cats.size(); i++) {
        Cat oneCat = (Cat)cats.get(i);
        if ( oneCat != this && dist(oneCat.posX, oneCat.posY, posX, posY) < distToNearestBuddy ) {
          distToNearestBuddy = dist(oneCat.posX, oneCat.posY, posX, posY);
          myBuddy = oneCat;
        }
      }

      if (myBuddy != null) {
        angle = atan2(myBuddy.posY-posY, myBuddy.posX-posX);
        speed = 2.6;
        if ( dist(myBuddy.posX, myBuddy.posY, posX, posY) < 5.0) {
          myBuddy.myMood = MOOD_WANDERING;
          myMood = MOOD_WANDERING;
          myBuddy.millis_NextRethink = millis() + 2000;
          millis_NextRethink = millis() + 2000;
          // SEX


          if (millis_wait < millis()) {

            sex.trigger(); 
            millis_wait = millis() + 6000;

            if ((int)random(10) > 7) {
              //      millis_TimeToLife = millis() + 40000 + (int)random(60000);
              cats.add( new Cat(myBuddy.posX, myBuddy.posY, (int)random(6), sineCat) );
            } 
            else {
              //      millis_TimeToLife = millis() + 40000 + (int)random(60000);
              cats.add( new Cat(myBuddy.posX, myBuddy.posY, myTaste, sineCat) );
            }
          }
        }
      } 
      else {
        myMood = MOOD_DANCING;
      }
      break;


    case MOOD_ATTACK_SPEAKER: 
      speed = 1.0*will;   
      for (int i=speakers.size()-1; i>=0; i--) {
        Speaker oneSpeaker = (Speaker)speakers.get(i);
        if (dist(oneSpeaker.speakerX, oneSpeaker.speakerY, posX, posY) < 200.0) {
          angle = atan2(oneSpeaker.speakerY-posY, oneSpeaker.speakerX-posX);
          speed = 1.0;    
          if (oneSpeaker.soundCheckKill((int)posX, (int)posY)) {
            destroy.trigger(); 
            speakers.remove(i);

            analAllMusic.remove(i);
          }
        }
      }
      break;

    case MOOD_ATTACK_DOG:
      angle = atan2(thePlayer.playerY-posY, thePlayer.playerX-posX);
      speed = 1.7*will;  
    millis_TimeToLife += 10000;  
      //    }
      break;

    case MOOD_RUN_FROM_USER:
      angle = atan2(mouseY-posY, mouseX-posX) + PI;
      speed = 2.0;
      break;
    }
  } // end of AI


  void checkControl() {

    if (mood == 0) {
      myMood = MOOD_STANDING;
    }
    if (mood == 1) {
      myMood = MOOD_WANDERING;
    }
    if (mood == 2) {
      myMood = MOOD_WANDERING_SEEK_BUDDY;
    }
    if (mood == 3) {
      myMood = MOOD_WANDER_CURIOUS;
    }
    if (mood == 4) {
      myMood = MOOD_DANCING;
    }
    if (mood == 5) {
      myMood = MOOD_DANCING_SEEK_BUDDY;
    }
    if (mood == 6) {
      myMood = MOOD_ATTACK_SPEAKER;
    }
    if (mood == 7) {
      myMood = MOOD_ATTACK_DOG;
    }
  }


  boolean tooHungry() {
    return (millis_TimeToLife < millis());
  }





  // Sound Check  
  boolean soundCheck(int x, int y) {
    if (dist(posX, posY, x, y) <= catRadius/2) {
      val = 0.1;
      soundOn = true;
      return true;
    } 
    else { 
      val = 0;
      soundOn = false;
      //    catSine.setAmp(0.);
      return false;
    }
  }


  boolean deathCheck(int x, int y) {
    if (dist(posX, posY, x, y) <= 25) {
      return true;
    } 
    else { 

      return false;
    }
  }

  // MOUSE CHECK
  void checkMouse() {
    if (soundCheck(mouseX, mouseY)) {

      val = 0.5;
    } 
    else {
      val = 0; 
      //     myTone = 0;
    }
  }  


  // SING
  void sing() {

    if (i >= 0) {
      //   println(myGen);
      i++;
      if (i >= myMusic.size()) {
        i = 0;
      }
      myTone = myMusic.get(i);
      float r = myTone/5000*catRadius;
      stroke(255);
      if (i > 0 && i < 5) {
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
        fill(255, 0, 0);
        ellipse(posX, posY, catRadius+20, catRadius+20);
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
      } 
      if (i > beat-2 && i < beat+2) {
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
        fill(100, 100, 255);
        ellipse(posX, posY, catRadius+20, catRadius+20);
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
      } 
      if (i > 2*beat-2 && i < 2*beat+2) {
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
        fill(100, 100, 255);
        ellipse(posX, posY, catRadius+20, catRadius+20);
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
      } 
      if (i > 3*beat-2 && i < 3*beat+2) {
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
        fill(100, 100, 255);
        ellipse(posX, posY, catRadius+20, catRadius+20);
        fill(0);
        ellipse(posX, posY, catRadius, catRadius);
      } 
      noFill();
      ellipse(  posX, posY, catRadius, catRadius);

      if (r != 0) {
        fill((int)random(255), (int)random(255), (int)random(255));
        noStroke();
        ellipse(posX, posY, r, r);
      }
      if (soundOn) {
        catSine.setFreq(myTone);
        catSine.setAmp(0.1);
      }



      if (i > 350) {
        catSine.setFreq(0);
        catSine.setAmp(0);
      }
    }
  }



  void drawAndMove() {
    posX += speed * cos(angle);
    posY += speed * sin(angle);

    AI();
    speakerCheck();
    boundsCheck();


    if (myMood == MOOD_STANDING) {
      //    checkMouse(); 
      sing();
    }


    if (myMood == MOOD_DANCING) {
      //     checkMouse(); 
      sing();
    }

    noStroke();

    // mood debug
    textSize(20);
    //  text(myMood, posX-10, posY-30);
    fill(180);
    textSize(10);
    text("dies in " + ((millis_TimeToLife-millis())/1000) + " sec", posX-30, posY+30);

    if (myMood == MOOD_DANCING) {
      image(cat_happy, posX-15, posY-14);
    }
    if (myMood == MOOD_DANCING_SEEK_BUDDY) {
      image(cat_happy, posX-15, posY-14);
    }
    if (myMood == MOOD_ATTACK_SPEAKER) {
      image(cat_angry, posX-15, posY-14);
    }
    if (myMood == MOOD_ATTACK_DOG) {
      image(cat_angry, posX-15, posY-14);
    } 
    else {
      image(cat_neutral, posX-15, posY-14);
    }
    stroke(255, 255, 0);
  }















  int iii;


  void taste(int iii, float entries, float average) {
    //   println("start taste. average: " + average + " entries: " + entries);
    if (average <= tasteAverage[iii]+500 && average >= tasteAverage[iii]-1500) {
      likeBeat++;
      if (entries >= tasteEntries[iii]) {
        likeBeat++;
        //      println("like Average - like Entries");
      } 
      else {
        likeBeat--;
        //      println("like Average - dislike Entries");
      }
    } // end If 
    else {
      likeBeat--;
      if (entries <= tasteEntries[iii]) {
        likeBeat++;
        //      println("dislike Average - like Entries");
      } 
      else {
        likeBeat--;
        //      println("dislike Average - dislike Entries");
      }
    } // end Else
    //    println(likeBeat);
  } // end tasteBeat Check


  //  }

  void boundsSpeaker(int speakerX, int speakerY, int mouseVolSave, int x, int y) {
    if (dist(speakerX, speakerY, x, y) >= mouseVolSave/2) {
      angle = random(0.0, TWO_PI);
    }
  }

  void speakerCheck() {
    for (int i=0; i<speakers.size(); i++) {
      Speaker oneSpeaker = (Speaker)speakers.get(i);
      if (oneSpeaker.soundCheck((int)posX, (int)posY)) {
        //   println("yeah" + i);
        // SOUNDANALYSE

        if (i >= speakers.size()) {
          break;
        }

        if (likeBeat > 1) {
          boundsSpeaker((int)oneSpeaker.speakerX, (int)oneSpeaker.speakerY, (int)oneSpeaker.mouseVolSave, (int)posX, (int)posY);
        }
        music = (ArrayList)analAllMusic.get(i);
        pieceEntries = (ArrayList)music.get(0);
        pieceAverage = (ArrayList)music.get(1);

        //     println("average: " + music.get(1) + " entries: " + music.get(0));


        if (millis_WaitTillCheckTaste < millis()) {
          millis_WaitTillCheckTaste = millis() + 500;
          fill(255);
          textSize(20);
          text("!", posX-10, posY-60);

          for (int ii=0; ii<pieceEntries.size(); ii++) {
            entries = (float)pieceEntries.get(ii);
            average = (float)pieceAverage.get(ii);



            taste(ii, entries, average);
          }
        }
      }
    }
    //    println(likeBeat);

    music = new ArrayList();
    pieceEntries = new ArrayList();
    pieceAverage = new ArrayList();
    entries = 0;
    average = 0;
  }

  void reset() {
    catSine.setFreq(0);
    //   catSine.setAmp(0);
    i = 0;
    //     sineCat.noPortamento();
  }

  void boundsCheck() {
    if (posX < 0) {
      posX = 0;
      angle = random(0.0, TWO_PI);
    }
    if (posX >= width) {
      posX = width-1;
      angle = random(0.0, TWO_PI);
    }
    if (posY < 0) {
      posY = 0;
      angle = random(0.0, TWO_PI);
    }
    if (posY >= height) {
      posY = height-1;
      angle = random(0.0, TWO_PI);
    }
  }
}

