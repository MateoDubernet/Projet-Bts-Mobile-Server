class Motif {
  private byte[] vitesses;
  private int[] pos;
  private boolean [] cibleAtteinte;

  long tInit;
  byte[] vCalc = new byte[nMoteurs];

  Motif() {
    vitesses = new byte[nMoteurs];
    pos = new int[nMoteurs];
    cibleAtteinte = new boolean[nMoteurs];
    tInit = System.nanoTime();
  }

  void maj(int[]_pos) {
    pos = _pos;
    vitesses = calcN();
  }

  byte[] calcN () { // calcule le nombre de pas à effectuer suivant le type de motif

    for (int i=0; i<nMoteurs; i++) {
      vCalc[i] = byte(casesMot[i].getVitesse());
    }

    return vCalc;
  }

  boolean atteindreCible(int cible, byte vit) {
    int nCiblesAtteintes = 0;
    for (int i = 0; i<nMoteurs; i++) {
      if (pos[i]==cible && cibleAtteinte[i]) {
        vCalc[i] = 0;
        nCiblesAtteintes ++;
      }

      if (!cibleAtteinte[i]) {
        if (abs(pos[i] - cible)>vit) {
          vCalc[i] = vit;
        } else {
          vCalc[i] = byte(abs(pos[i] - cible));
          cibleAtteinte[i] = true;
        }
        if (pos[i] > cible) vCalc[i]*=-1;
      }
    }
    if (nCiblesAtteintes == nMoteurs) {
      cibleAtteinte = new boolean[nMoteurs];
      return true;
    } else {
      return false;
    }
  }

  byte[] getVitesse() {
    return vitesses;
  }

  void raz() {
    for (int i=0; i<nMoteurs; i++) {
      pos[i] = 0;
      vitesses[i] = 0;
    }
  }
}
