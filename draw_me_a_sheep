// dessin de moutons en arc en ciel

color gris = color(90, 90, 90);
color blanc= color(255, 255, 255);
color rouge = color(255, 0, 0);
color orange = color(255, 150, 0);
color jaune = color(255, 255, 0);
color vert = color(0, 255, 0);
color indigo = color(0, 255, 255);
color bleu = color(0, 0, 255);
color violet = color(155, 0, 255);

color[] tabl_color = {blanc, violet, bleu, indigo, vert, jaune, orange, rouge};

float MoutonY= 600;
float MoutonX= 740;

float centre_rayon_x = 740;
float centre_rayon_y =600;
float angle_pas_mouton= -PI/(tabl_color.length-2); // pour un demi-cercle inversé, - 1 mouton


void setup () {
size(1800, 1000);
background(70, 150, 70);

  for (int M=0; M<tabl_color.length; M++) {
    
    mouton (M, MoutonX, MoutonY);
    MoutonX = centre_rayon_x+cos(angle_pas_mouton*M)*500 ;
    MoutonY = centre_rayon_y+sin(angle_pas_mouton*M)*500 ;
  }
}

void mouton (int k, float MoutonX, float MoutonY){
fill(tabl_color[k]);
rect(MoutonX, MoutonY, 320, 220, 70); // corps
rect((MoutonX + 80), (MoutonY+220), 40, 90); //pate arrière
rect((MoutonX + 120), (MoutonY+220), 20, 70); //pate arrière2

rect((MoutonX+200), (MoutonY+220), 40, 90); // pate avant
rect((MoutonX+240), (MoutonY+220), 20, 70); // pate avant 2
rect((MoutonX+320), (MoutonY+45), 150, 100, 50); // tête
fill(gris);
rect((MoutonX+360), (MoutonY+60), 30, 30, 50); // oeil
}
