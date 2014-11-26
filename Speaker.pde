class Speaker {

  float pitch_old;
  float mouseVolSave;
  float speakerX, speakerY;
  int sel;
  float val = 0;
  boolean stop1;
  boolean stop2;
  int beat = 87;

  SineWave theSine;

  ArrayList<Float> sound = new ArrayList();

  int i;

  ArrayList analAllMusic = new ArrayList();



  Speaker(int tempSpeakerX, int tempSpeakerY, float tempSpeakerVolume, int tempSelect, SineWave tempSine) {
    speakerX = tempSpeakerX;
    speakerY = tempSpeakerY;
    mouseVolSave = tempSpeakerVolume;
    sel = tempSelect;
    theSine = tempSine;
  }


  // Sound Check
  boolean soundCheck(int x, int y) {
    if (dist(speakerX, speakerY, x, y) <= mouseVolSave/2) {
      val = 0.1;
      return true;
    } 
    else { 
      val = 0;
      return false;
    }
  }

  boolean soundCheckKill(int x, int y) {
    if (dist(speakerX, speakerY, x, y) <= 15) {
      return true;
    } 
    else { 
      return false;
    }
  }

  // SPEAKER Check
  boolean speakerCheck(int x, int y) {
    if (dist(speakerX, speakerY, x, y) <= mouseVolSave/2) {
      return true;
    } 
    else { 
      return false;
    }
  }


  // draw speaker
  void drawSpeaker() { 
    sound = (ArrayList)allMusic.get(sel);

    if (i >= 0) {
      i++;
      if (i >= sound.size()-1) {
        i = 0;
      }
      pitch_old = sound.get(i);
      float r = pitch_old/5000*mouseVolSave;


      stroke(255);

      if (i > 0 && i < 5) {
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
        fill(255, 0, 0);
        ellipse(speakerX, speakerY, mouseVolSave+20, mouseVolSave+20);
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
      } 
      if (i > beat-2 && i < beat+2) {
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
        fill(100, 100, 255);
        ellipse(speakerX, speakerY, mouseVolSave+20, mouseVolSave+20);
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
      } 
      if (i > 2*beat-2 && i < 2*beat+2) {
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
        fill(100, 100, 255);
        ellipse(speakerX, speakerY, mouseVolSave+20, mouseVolSave+20);
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
      } 
      if (i > 3*beat-2 && i < 3*beat+2) {
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
        fill(100, 100, 255);
        ellipse(speakerX, speakerY, mouseVolSave+20, mouseVolSave+20);
        fill(0);
        ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);
      } 

      noFill();
      ellipse(speakerX, speakerY, mouseVolSave, mouseVolSave);

      if (r != 0) {
        noStroke();
        fill(255, 95);
        ellipse(speakerX, speakerY, r, r);
      }

      image(speaker, speakerX-15, speakerY-15);


      theSine.setFreq(pitch_old);
      theSine.setAmp(val);

      if (analFrame > 349) {
        theSine.setFreq(0);
      }
    }
  }

  void reset() {
    i = 0;
  }

  void kill() {
    sound = new ArrayList();
    theSine.setFreq(0);
  }
}

