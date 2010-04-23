import org.mozilla.browser.MozillaWindow;
import com.rngtng.launchpad.*;
import java.awt.*;

Launchpad launchpad;
MozillaPanel moz;

int first_coord = -1;

void setup() {
  launchpad = new Launchpad(this);
  size(1070, 880);
  moz = new MozillaPanel(MozillaWindow.VisibilityMode.FORCED_HIDDEN, MozillaWindow.VisibilityMode.FORCED_HIDDEN);
  setLayout(new GridLayout(1,0));
  add(moz);
  //moz.load("http://instantsfun.es");
  MozillaAutomation.blockingLoad(moz, "http://instantsfun.es");
  int bsize = 60;
  String script = "(for(i = 0; i < 64; i++) { document.embeds[i].width="+bsize+"; document.embeds[i].height="+bsize+"; };window.scrollTo(10, 220);)";
  println(script);
  MozillaAutomation.executeJavascript(moz, script);
}

void draw() {    
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
