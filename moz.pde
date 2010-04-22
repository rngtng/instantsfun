import org.mozilla.browser.MozillaWindow;

MozillaPanel moz;

void setup() {
  size(1050, 800);
  moz = new MozillaPanel(MozillaWindow.VisibilityMode.FORCED_HIDDEN, MozillaWindow.VisibilityMode.FORCED_HIDDEN);
  setLayout(new GridLayout(1,0));
  add(moz);  
  moz.load("http://instantsfun.es");  
}

void draw() {
}


void keyPressed() {
  moz.load("javascript:document.embeds[("+key+"-1)].GotoFrame(1)");
}


