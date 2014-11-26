boolean control;
int catSpeakCharacter = 200;

class Keyboard {
  boolean holdingLeft = false;
  boolean holdingRight = false;
  boolean holdingUp = false;
  boolean holdingDown = false;
  int i;

  void modifyKey(int key, boolean setThatKeyTo) {
    if (key == KeyEvent.VK_A) {
      holdingLeft = setThatKeyTo;
    }
    if (key == KeyEvent.VK_D) {
      holdingRight = setThatKeyTo;
    }
    if (key == KeyEvent.VK_W) {
      holdingUp = setThatKeyTo;
    }
    if (key == KeyEvent.VK_S) {
      holdingDown = setThatKeyTo;
    }

    if (key == KeyEvent.VK_0 && setThatKeyTo == false) {
      control = !control;
    }

    if (key == KeyEvent.VK_C) {

      if (noCat) {

        i = 0;      
    //    catSpeakCharacter = 100+(int)random(100);
        sineCat = new SineWave(0, 0.5, out.sampleRate());
        sineCat.portamento(catSpeakCharacter);
        out.addSignal(sineCat);

        int tastRandom1 = (int)random(6);


        cats.add( new Cat(mouseX, mouseY, tastRandom1, sineCat) );

        int tastRandom2 = (int)random(6);

        if ((int)random(11) > 5) {
          cats.add( new Cat((int)random(1000), (int)random(600), tastRandom2, sineCat) );
        }

        if (tastRandom1 == tastRandom2) {
          int tastTemp = tastRandom1-1;
          if (tastTemp >=0) {

            cats.add( new Cat((int)random(1000), (int)random(600), tastTemp, sineCat) );
          } 
          else {
            int tastTemp2 = tastRandom1+1;
            cats.add( new Cat(mouseX, mouseY, tastTemp2, sineCat) );
          }
        } 
        else {
          cats.add( new Cat((int)random(1000), (int)random(600), tastRandom2, sineCat) );
        }

        // (int)random(5)

        for (int i=cats.size()-1; i>=0; i--) {
          Cat oneCat = (Cat)cats.get(i);
          oneCat.reset();
        }
      }
    }

    if (key == KeyEvent.VK_SPACE && setThatKeyTo == false) {
      once = true;
      currentScreen++;
      if (currentScreen > 1) { 
        currentScreen = 2;
      }
    }
  } // end of press key
} // end of class

