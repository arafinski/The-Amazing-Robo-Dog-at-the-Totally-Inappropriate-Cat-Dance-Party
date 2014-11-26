// Sound Bar
boolean barOn = false;
float mouseBarX;
int frameCount_start;

boolean playSmart = true;

int beginn = 0;
float barStart;
int barStartDelay1;
int barStartDelay2;
int barX_end;
float barX;
float pitch;
float freq;
int barX_Count;
boolean bang = false;
boolean drawLine = false;
boolean barOff = true;
boolean barDelay = true;
boolean startMusic = false;
int barLength = 800;
int barHeight = 100;
float barBeat = barLength/4;
float mouseVol, mouseVolSave;
int speakerX, speakerY;
float mouseBarX_old;
float mouseBarXResult_old;
float mouseBarXanalyse_old;
float ii;
int analFrame;
float analAverage = 0;
float analAverageSave;
float analEntries;
int analBeat = 87;
int checkTone = 0;

// change speaker character
int speakCharacter = 200;

int select = -1;

boolean isSpeaker = false;

int i;

void bar() {
  if (barOn) {

    barOff = false;

    // delay
    if (barDelay) {


      ellipse(speakerX, speakerY, 100, 100);

      if (barStartDelay2 > frameCount  ) {
        textSize(100);
        fill(255, 0, 0);
        text("2", width/2, height/2);
        textSize(12);
      }
      else if ( barStartDelay1 > frameCount) {
        textSize(100);
        fill(255, 0, 0);
        text("1", width/2, height/2);
        textSize(12);
      }
      if ( barStartDelay1 == frameCount) {
        barDelay = false;
      }
    } 
    else {

      analFrame++;

      barX = barX + 2.28;
      barX_Count++;
      // representation Pitch
      mouseBarX = 100*mouseX/1000;
      mouseBarX = constrain(mouseBarX, 0, 100); //-> save into array
      pitch = mouseBarX*50;

      mouseBarXanalyse += mouseBarX; 


      if (drawLine) {
        checkTone++; 
        analEntries++;
        analAverage = analAverage + pitch;
        music.add(pitch);
        sine.setFreq(pitch);

        drawBuf.beginDraw();
        drawBuf.stroke(255);
        drawBuf.line(barX+width/2-barLength/2, 200, barX+width/2-barLength/2, 200-mouseBarX);
        drawBuf.endDraw();
      } 
      else {
        freq = 0;
        music.add(freq);
        sine.setFreq(freq);
      }

      stroke(255, 0, 0);
      line(barX+width/2-barLength/2, 200, barX+width/2-barLength/2, 100);
      stroke(0, 0, 255);
      line(barBeat+width/2-barLength/2, 200, barBeat+width/2-barLength/2, 100);
      line(2*barBeat+width/2-barLength/2, 200, 2*barBeat+width/2-barLength/2, 100);
      line(3*barBeat+width/2-barLength/2, 200, 3*barBeat+width/2-barLength/2, 100);

      if (analFrame == analBeat) {
        analAverageSave = analAverage / analBeat;      
        analPieceEntries.add(analEntries);  
        analPieceAverage.add(analAverageSave);
        analAverage = 0;
        analEntries = 0;
      }
      if (analFrame == 2*analBeat) {
        analAverageSave = analAverage / analBeat;      
        analPieceEntries.add(analEntries);  
        analPieceAverage.add(analAverageSave);
        analAverage = 0;
        analEntries = 0;
      }
      if (analFrame == 3*analBeat) {
        analAverageSave = analAverage / analBeat;      
        analPieceEntries.add(analEntries);  
        analPieceAverage.add(analAverageSave);
        analAverage = 0;
        analEntries = 0;
      }
      if (analFrame == 4*analBeat) {
        analAverageSave = analAverage / analBeat;      
        analPieceEntries.add(analEntries);  
        analPieceAverage.add(analAverageSave);
        analAverage = 0;
        analEntries = 0;
      }


      // representation volume
      mouseVol = (500-mouseY);
      mouseVol = constrain(mouseVol, 50, 500); //-> save into array
      stroke(255, 0, 0);
      ellipse(speakerX, speakerY, mouseVol, mouseVol);
      stroke(255);

      if (analFrame > 349) {
        sine.setFreq(0);
      } 

      if ( barStart-1 < frameCount ) {

        background(255, 0, 0);

        barStart = frameCount + rythmGlobal; 
        barOn=false;
        barOff=true;
        barX = 0;
        barX_end = barX_Count;
        barX_Count = 0;
        mouseBarXResult = mouseBarXanalyse / 351;
        mouseBarXanalyse = 0;
        drawBuf.beginDraw();
        drawBuf.fill(0);
        drawBuf.rect(width/2-barLength/2, barHeight, barLength, barHeight);
        drawBuf.endDraw();

        barDelay = true;
        freq = 0;
        sine.setFreq(freq);

        mouseVolSave = (500-mouseY);


        // check if any tone made

        if (checkTone > 0) {
          select++;
          SineWave sine2 = new SineWave(0, 0.5, out.sampleRate());
          sine2.portamento(speakCharacter);
          out.addSignal(sine2);

          analMusic.add(analPieceEntries);
          analMusic.add(analPieceAverage);

          analAllMusic.add(analMusic);

          playSmart = !playSmart;
          speakers.add( new Speaker(speakerX, speakerY, mouseVolSave, select, sine2));
          allMusic.add(music);



          for (int i=0; i<speakers.size(); i++) {
            Speaker oneSpeaker = (Speaker)speakers.get(i);
            oneSpeaker.reset();
          }
        }
        analPieceEntries = new ArrayList();
        analPieceAverage = new ArrayList();
        analMusic = new ArrayList();
        music = new ArrayList();
        analFrame = 0;
        checkTone = 0;
      }
    }
  }
}

