import websockets.*;
import processing.serial.*;
public class Communications extends Thread {
  Motif motif;
  int[] positions;
  byte[] vitesses;
  long maintenant, to;
  byte in = 6;
  
  Serial myPort ;
  WebsocketServer ws;
  String ModeRecu = "";
  String MotifRecu = "";


  Communications(PApplet _pApplet) {
    pApplet = _pApplet;
    motif = new Motif();
    positions = new int[nMoteurs];
    vitesses = new byte [nMoteurs];
    ws = new WebsocketServer(pApplet, 8484, "/mobile");
    to=System.nanoTime();
  }

  void start() {
    super.start();
  }

  void run() {
    while (true) {
      maintenant = System.nanoTime();
      int dt = 73530*256;
      if ((maintenant - to)>dt) { // permet de simuler le comportement d'Arduino ...
        if (in == 6) {
          motif.maj(positions);
          calcVitesses();
          calcPos();
          String msg="POS,";
          for (int i = 0; i<nMoteurs; i++) {
            msg +=positions[i] + ",";
          }
          msg+="FIN";
          ws.sendMessage(msg);
        } else {
          print(hex(in) + " ");
        }
        to = to + dt;
      } else delay(1); 
    }
  }


  void calcVitesses() {
    motif.maj(positions);
    vitesses = motif.getVitesse();
  }

  void calcPos() {
    for (int i =0; i<nMoteurs; i++) {
      positions[i] += vitesses[i];
    }
  }

  

  byte[] getVitesses() {
    return vitesses;
  }

  int[] getPos() {
    return positions;
  }

  void setWsRecu(String _s) {
    if (_s.equals("on")) on = true;
    else if (_s.equals("off")) on = false;
    else if (_s.equals("raz")) {
      for (int i=0; i<nMoteurs; i++) {
        casesMot[i].sel = false;
        casesMot[i].setVitesse(0);
        motif.raz();
        positions[i] = 0;
        vitesses[i] = 0;
      }
    } else if (_s.substring(0, 4).equals("vmot")) {
      int idMot = int(_s.substring(4, 7));
      println("Moteur= "+idMot);
      int vMot = int(_s.substring(8, _s.length()));
      println("Vitesse= "+vMot);
      casesMot[idMot].sel = true;
      casesMot[idMot].setVitesse(vMot);
      
    } else if (_s.substring(0, 6).equals("motif=")) {
      MotifRecu = _s.substring(6, _s.length());
      println("nouveau motif = " + MotifRecu);
    } else if (_s.substring(0, 5).equals("mode=")) {
      ModeRecu = _s.substring(5, _s.length());
      //TO DO
      println("nouveau mode = " + ModeRecu);
    } else println("message ws recu inconnu = " + _s);
  }

  void resetPos() {
    for (int i =0; i<nMoteurs; i++) {
      positions[i] = 0;
    }
  }
 
  
  
  
  
  /*void serialEvent(Serial p) 
{ 
  byte in = byte(p.readChar());
  if (in == 6)
  {
    for (int i=0; i<nMoteurs; i++)
    {
      myPort.write(vitesses[i]);
      calcPos();
      motif.maj(positions);
    }
    myPort.write(0x80);
    //myPort.write(vitesse[0]);
  } else
  {
    println(hex(in));
  }
}

void connexionSerie()
{
  try // essaie une opération "risquée"
  {
    printArray(Serial.list()); // Liste tous les ports disponibles
    int i = Serial.list().length; // i prend la valeur de la longueur des ports disponibles
    if (i != 0) 
    {
      String portName = Serial.list()[i-1]; 
      myPort = new Serial(this, portName, 115200); // change le baudrate comme on le souhaite
    } else 
    {
      print("Aucun Arduino n'est connecté");
      exit();
    }
  }
  catch (Exception e) // si le try ne fonctionne pas :
  { 
    print("Port COM pas disponible");
    println("Error:", e);
    exit();
  }
}*/
}
