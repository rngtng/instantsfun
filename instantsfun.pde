import org.mozilla.browser.MozillaWindow;
import com.rngtng.launchpad.*;

Launchpad launchpad;
MozillaPanel moz;

int x;
int y;
boolean y_set = false;

void setup() {
  launchpad = new Launchpad(this);
  size(1050, 800);
  moz = new MozillaPanel(MozillaWindow.VisibilityMode.FORCED_HIDDEN, MozillaWindow.VisibilityMode.FORCED_HIDDEN);
  setLayout(new GridLayout(1,0));
  add(moz);
  //moz.load("http://instantsfun.es");
  MozillaAutomation.blockingLoad(moz, "http://instantsfun.es");
  MozillaAutomation.executeJavascript(moz, "window.scrollTo(0, 220);");
  
  // moz.addMouseListener(new MouseListener() {
  //     public void mouseClicked(MouseEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void mouseEntered(MouseEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void mouseExited(MouseEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void mousePressed(MouseEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void mouseReleased(MouseEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  // });
  // 
  // moz.addKeyListener(new KeyListener() {
  //     public void keyPressed(KeyEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void keyReleased(KeyEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  //     public void keyTyped(KeyEvent e) {
  //         System.err.println("received "+e); //$NON-NLS-1$
  //     }
  // });  
}

void draw() {    
}

void launchpadGridPressed(int _x, int _y) {
  launchpad.changeGrid(x, y, LColor.RED_HIGH);
  x = _x;
  y = _y;
  exec();
}

public void launchpadGridReleased(int x, int y) {
  launchpad.changeGrid(x, y, LColor.RED_LOW);
}

void keyPressed() {
  if(!y_set) {
      y = int(key) - 48;
      y_set = true;
  }
  else {
      x = int(key) - 48;
      exec();
  }
}


void exec() {
    int pos = 8 * (y - 1) + (x - 1);
    MozillaAutomation.executeJavascript(moz, "document.embeds["+pos+"].GotoFrame(1)");
    println("Exec: " + x + "  " + y);
    y_set = false;
}
