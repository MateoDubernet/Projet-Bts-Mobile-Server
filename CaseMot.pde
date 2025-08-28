class CaseMot {
  private int xAff, yAff;
  private int l,h;
  private boolean sel = false;
  private int id = 0;
  private String textPos = "pos = 0";
  private String textVit = "vit = 0";
  private byte vitesse;
  
  CaseMot(int _id){
    vitesse = 0;
    id = _id;
    l = width/(nMoteurs/2);
    h = height/4;
    xAff = (id%(nMoteurs/2))*l;
    yAff = floor(id/(nMoteurs/2))*h+height/2;
  }
  
  void maj(){
    aff();
  }
  
  void aff(){
    if(isSel()) fill(0,180,0);
    else if (mouseOver()) fill(100);
    else fill(0);
    
    rect(xAff,yAff,l,h);
    fill(255);
    text(id,xAff+10,yAff+20);
    textPos = "pos = " + com.getPos()[id];
    text(textPos,xAff+10,yAff+40);
    text(textVit,xAff+10,yAff+60);

  }
  
  boolean mouseOver(){
    if(mouseX>xAff && mouseX<xAff+l && mouseY>yAff && mouseY<yAff+h) return true;
    else return false;
  }
  
  boolean isSel(){
    if(mousePressed && (mouseButton == LEFT) && mouseOver()){
      for(int i=0;i<nMoteurs;i++){
        if (i != id) casesMot[i].sel = false;
      }
      sel = true;
    }
    return sel;
  }
  
  void incVitesse(int e){
    if(sel) vitesse +=e;
    if(vitesse>127) vitesse = 127;
    if(vitesse<-127) vitesse = -127;
    textVit = "vit = " + vitesse;
    
  }
  
  byte getVitesse(){
    return vitesse;
    //print(vitesse + " ; ");
  }

  void setVitesse(int _v){
    vitesse = byte(_v);
    textVit = "vit = " + vitesse;
  }

}
