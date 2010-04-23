import org.mozilla.browser.MozillaWindow;
import com.rngtng.launchpad.*;
import java.awt.*;

Launchpad launchpad;
MozillaPanel moz;
Frame f;

int first_coord = -1;

void setup() {
  load_splash_screen();

  launchpad = new Launchpad(this);
  
  size(1040, 840);  
  moz = new MozillaPanel(MozillaWindow.VisibilityMode.FORCED_HIDDEN, MozillaWindow.VisibilityMode.FORCED_HIDDEN);
  add(moz);
  setLayout(new GridLayout(1,0));

  load_instantsfun();
}


void draw() {
}

/********************* W E B S I T E **************************/

void load_splash_screen() {
   Label lbl = new Label("\n\nLOADING...", Label.CENTER);
   f = new Frame();
   f.add(lbl);
   f.setSize(300,100);
   f.setUndecorated(true);
   f.setLocation((screen.width/2)-100,(screen.height/2)-100);
   f.setVisible(true);    
}

void load_instantsfun() {
   moz.setVisible(false);
   int bsize = 65;
   String script = "for(i = 0; i < 64; i++){ document.embeds[i].width="+bsize+"; document.embeds[i].height="+(bsize-10)+"; };document.documentElement.style.overflow = 'hidden';window.scrollTo(20, 220);";

   MozillaAutomation.blockingLoad(moz, "http://instantsfun.es");
   //moz.load("http://instantsfun.es");
   moz.load("javascript:"+script);
   println("done");
   f.setVisible(false);
   moz.setVisible(true);
}


/********************* E V E N T S ****************************/

void launchpadGridPressed(int x, int y) {
  launchpad.changeGrid(x, y, LColor.RED_HIGH);
  shout(x,y);
}

public void launchpadGridReleased(int x, int y) {
  launchpad.changeGrid(x, y, LColor.RED_LOW);
}

void keyPressed() {
 int coord = int(key) - 49;
  if(first_coord < 0) {
      first_coord = coord;
      return;
  }
  shout(first_coord, coord);
  first_coord = -1;
}

/********************* E X E C U T E **************************/

void shout(int x, int y) {
    int pos = 8 * y + x;
    MozillaAutomation.executeJavascript(moz, "document.embeds["+pos+"].GotoFrame(1)");
}
