boolean [] cheminDeToto = new boolean[8];

void setup() {
  poseFlaque();
  for (int i=0; i<(cheminDeToto.length); i++) { 
    if (!maPosition(i)) {
      break;
    } else {
    isNearWater(i);
    i= go(i);
    println("");
    }
  }
}


void poseFlaque() {      //les flaques doivent être attribuées dans une fonction.
  for (int c=0 ; c<cheminDeToto.length ; c++) {
    if ((c==2) || (c==4)) {
      cheminDeToto[c] = true;
    } else {
      cheminDeToto[c] = false;
    }
  }
}

boolean maPosition(int p) {
  println("je suis sur la case " + p + " du chemin.");
   if (p== cheminDeToto.length-1) {
        println("JE SUIS ARRIVE !!!");
        return false;
   } else {
      println("il me reste " + (cheminDeToto.length - p-1) + " case à franchir.");
      println("Devant moi il y a : " + cheminDeToto[p+1]);
      return true;
   }
 
}

boolean isNearWater(int i) {
   if (cheminDeToto[i+1] == true) {
      return true;
   } else {
      return false;
   } 
}

int go(int g) {
  if (isNearWater(g)) {
        println("je dois sauter ! J'avance de 2 cases.");
        return g+1;
  } else {
        println("je peux marcher, j'avance d'une case.");
        return g;
  }
}
