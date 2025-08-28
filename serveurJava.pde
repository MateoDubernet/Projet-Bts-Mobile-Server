Communications com;
PApplet pApplet;
int nMoteurs = 10;
CaseMot [] casesMot;
boolean on = false;


void setup() {
  size(800, 600, P3D);
  fill(255);
  stroke(255);
  textSize(16);

  casesMot = new CaseMot[nMoteurs];
  for (int i = 0; i<nMoteurs; i++) {
    casesMot[i] = new CaseMot(i);
  }

  pApplet = this;

  com = new Communications(pApplet);

  com.start();

}

void draw() {
  background(0);
  fill(255);
  for (int i = 0; i<nMoteurs; i++) {
      casesMot[i].maj();
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  for (int i = 0; i<nMoteurs; i++) {
    casesMot[i].incVitesse(int(-e));
  }
}

void webSocketServerEvent(String msg) {
  com.setWsRecu(msg);
  println("recu du websocket client = \t" + msg);
  
}
