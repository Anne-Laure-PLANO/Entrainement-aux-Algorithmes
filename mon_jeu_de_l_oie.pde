// ce projet est en cours de finition. Il reste des arguments à inclure (cases bloquées pendant 2 tours, déblocage du joueurs si l'adversaire tombe sur sa case)

int[]tab_plateau;
int largeurCases = 23;
int hauteurCases = 80;
int nbreDeCases = 64;
int joueurActuel = 0;
boolean[] tab_canIPlay; 
boolean[] tab_firstPlay;
int nbDeJoueurs = 3;
boolean gameOver = false;
int[] tab_positionJoueurs ;
int [] tab_penaliteJoueurs;

void setup() {
  size (1800, 200);
  rectMode(CENTER); 
  textAlign(CENTER, CENTER);
  frameRate(1); // ralentissement 1x/sec 
  noLoop();

  tab_positionJoueurs = init_tableau_position_joueurs(nbDeJoueurs);
  tab_plateau = inittab_plateau(nbreDeCases, largeurCases);
  tab_canIPlay = init_tableau_canIPlay(nbDeJoueurs);
  tab_firstPlay = init_tableau_firstPlay(nbDeJoueurs);
}




void draw() {
  background(155, 155, 155);
  dessiner_tab_plateau(tab_plateau, hauteurCases, largeurCases);
  println();
  
  //test si le joueur peut jouer, sinon s'il a des points de tour de pénalité. si oui, on décrémente.
  boolean JoueurBloque = true;
  while (JoueurBloque){
    JoueurBloque = canPlayerPlay (tab_canIPlay, joueurActuel);
    if (JoueurBloque){
      tab_penaliteJoueurs[joueurActuel] = decreasePenality(tab_penaliteJoueurs, joueurActuel);
      tab_canIPlay[joueurActuel] = leveeBlocage (tab_penaliteJoueurs, joueurActuel, tab_positionJoueurs);
      joueurActuel = nextPlayer(joueurActuel, nbDeJoueurs);
    }
  }
  println("tour du joueur : " + int(joueurActuel));
  println("le joueur n°" + joueurActuel + " commence son tour à la position " + tab_positionJoueurs[joueurActuel]);

  int positionInitiale = tab_positionJoueurs[joueurActuel];
  int valeurDe1 = lancerDes();
  int valeurDe2 = lancerDes();
  println("le joueur a fait un "+valeurDe1 + " et un " + valeurDe2);
  int totalDes = valeurDe1 + valeurDe2;

  tab_positionJoueurs[joueurActuel] = testCaseOie_et_incrementationScore (tab_positionJoueurs, joueurActuel, totalDes, tab_firstPlay) ;
 
  boolean joueurFirstPlay = testFirstPlay(tab_firstPlay, joueurActuel);
  if(joueurFirstPlay){
    tab_positionJoueurs[joueurActuel] = conditionPremierTour (valeurDe1, valeurDe2, totalDes, joueurActuel, tab_positionJoueurs);
    tab_firstPlay[joueurActuel] = false;
  }

tab_positionJoueurs[joueurActuel] = ifPositionIsSpecialCase (tab_positionJoueurs, joueurActuel);
tab_canIPlay[joueurActuel] = ifPositionIsLockedCase (tab_positionJoueurs, joueurActuel, tab_canIPlay);
tab_positionJoueurs = verifierSiPositionDejaOccupee (tab_positionJoueurs, joueurActuel, positionInitiale);
gameOver = isAVictory (joueurActuel, tab_positionJoueurs);
 
println("le joueur n°" + joueurActuel + " est à la position " + tab_positionJoueurs[joueurActuel]);
afficherJoueurs(tab_positionJoueurs, tab_plateau, hauteurCases, nbDeJoueurs);
joueurActuel = nextPlayer(joueurActuel, nbDeJoueurs);
noLoop();

}


boolean isAVictory (int joueurConcerne, int[] tableau_scoreJoueurs){
  if (tableau_scoreJoueurs[joueurConcerne]==63) {
    fill(255,0,0);
    textSize(128);
    text("Jeu fini, bravo au gagnant !", 900, 150);
    return true;
  }
  return false;
}


int lancerDes () {
  int valeur = int(random(1, 7));
  return valeur;
}


void mouseClicked(){
 if (!gameOver) {
   redraw(); 
 }
}


void afficherJoueurs (int[] positionJoueurs, int[] tab_plateau, int hauteurCases, int nbDeJoueurs) {
  color couleur_joueur;
  for (int i=0 ; i<nbDeJoueurs ; i++){
      if (i == 0){
        couleur_joueur = color(255,0,0);   
      }
      else if (i == 1) {
        couleur_joueur = color(0,255,0);  
      }
      else if (i == 2) {
        couleur_joueur = color(0,0,255);   
      } 
      else {
        couleur_joueur = color(155,155,155);   
      }
      fill(couleur_joueur);
      rect(tab_plateau[positionJoueurs[i]], hauteurCases, 16, 16);
      fill(255);
      text(i+1, tab_plateau[positionJoueurs[i]], hauteurCases);
      fill(0, 0, 250);
      text(i, tab_plateau[positionJoueurs[i]], hauteurCases-20);
    }
}


boolean canPlayerPlay (boolean[]tab_canIPlay, int joueurActuel){
   if (!tab_canIPlay[joueurActuel]){ 
    return true;
  } else {
    return false;
  }
}


int decreasePenality (int[] tab_penalite, int joueurConcerne){
   if (tab_penalite[joueurConcerne]>0){
     return tab_penalite[joueurConcerne]-1;
   } else {
     return tab_penalite[joueurConcerne];
   }
}


boolean leveeBlocage (int[]tab_penaliteJoueur, int joueurActuel, int[] tab_positionJoueurs){
  if (tab_penaliteJoueur[joueurActuel]==0 && tab_positionJoueurs[joueurActuel] != 3 && tab_positionJoueurs[joueurActuel] != 52){
    return false;
  } else {
    return true;
  }
} 


boolean testFirstPlay (boolean[] tab_isFirstPlay, int joueurConcerne){
  if (tab_isFirstPlay[joueurConcerne]){
    return true;
  }else {
    return false;
  }
}


int nextPlayer(int joueurActuel, int nbDeJoueurs){
  if (joueurActuel == nbDeJoueurs-1){
    joueurActuel = 0;
  } else {
    joueurActuel += 1;
  }
  return joueurActuel;
}


int[] init_tableau_position_joueurs(int nbJoueurs) {
  int[] ScoreJoueurs = new int [nbJoueurs];
  return ScoreJoueurs;
}


int conditionPremierTour (int valeurDe1, int valeurDe2, int sommeDes, int joueurConcerne, int[]listeJoueurs){
  println("test des conditions du premier tour");
  if (valeurDe1==6 && valeurDe2==3 || valeurDe1==3 && valeurDe2==6){
    println("Le joueur a fait un 3 et un 6, il va directement à la case 26");
    listeJoueurs[joueurConcerne]=26;
  }else if (valeurDe1==4 && valeurDe2==5 || valeurDe1==5 && valeurDe2==4) {
    println("le joueur a fait un 4 et un 5, il va directement à la case 53");
    listeJoueurs[joueurConcerne]=53;
  }else if (sommeDes==6) {
    println("le joueur a obtenu un résultat de 6, il va directement à la case 12");
    listeJoueurs[joueurConcerne]=12;
  }
  return listeJoueurs[joueurConcerne];
}
  

int[] verifierSiPositionDejaOccupee (int[]liste_score_joueurs, int positionJoueurConcerne, int positionInitialeJoueurConcerne){
  println("test si la position est déjà occupée");
  for (int i=0 ; i< nbDeJoueurs ; i++){
     if (positionJoueurConcerne == i) {
     continue;
   }
     if (liste_score_joueurs[positionJoueurConcerne] == liste_score_joueurs[i] && liste_score_joueurs[positionJoueurConcerne] !=0){
       liste_score_joueurs[i] = positionInitialeJoueurConcerne;
       println("le joueur échange de place avec le joueur "+ i);
     }
   }
   return liste_score_joueurs;
}



int testCaseOie_et_incrementationScore (int[] tableauJoueur, int joueurConcerne, int total_des, boolean[] tab_isFirstPlay) {
  println("test si la case est une oie");
  int[] casesOie = {9, 18, 27, 36, 45, 54};
  int scoreJoueur = tableauJoueur[joueurConcerne] + total_des;
  
  for ( int i=0; i<casesOie.length ; i++) {
    if (casesOie[i]== scoreJoueur && !tab_isFirstPlay[joueurConcerne]) {
      println("le joueur est tombé sur une oie, la valeur des dés est doublée.");
      scoreJoueur +=total_des;
    }
  }
  if (scoreJoueur> 63) {
    println("le score du joueur est supérieur au plateau, il doit reculer");
    scoreJoueur = 63 - (scoreJoueur - 63);
    if (scoreJoueur == 54){
      println("en reculant, le joueur est tombé sur une case oie. Il peut avancer de nouveau de la somme de ses dés");
      scoreJoueur += total_des;
    }
  }
  return scoreJoueur;
}


boolean ifPositionIsLockedCase (int[]tableauJoueur, int joueurConcerne, boolean[] tableauCanIPlay){
  println("vérification si le joueur est tombé sur une case verrouillante");
  switch (tableauJoueur[joueurConcerne]) {
    case 3 :
      println("le joueur n°" + joueurConcerne + " est tombé dans le puits. Il est bloqué jusqu'à ce qu'un autre joueur prenne sa place.");
      return tableauCanIPlay[joueurConcerne] = false;
    case 52 :
      println("le joueur n°" + joueurConcerne + " est en prison. Il est bloqué jusqu'à ce qu'un autre joueur prenne sa place.");
      return tableauCanIPlay[joueurConcerne] = false;
    default :
      return tableauCanIPlay[joueurConcerne] = true;
  }
}


int ifPositionIsSpecialCase (int[] tableauJoueur, int joueurConcerne) {
  println("vérification si le joueur est tombé sur une case spéciale");
  switch (tableauJoueur[joueurConcerne]){      
    case 42 :
      println("Le joueur n°" + joueurConcerne + " s'est perdu dans le labyrinthe. Il retourne à la case 30.");
      return tableauJoueur[joueurConcerne]=30;
    case 58 :
      println("Le joueur n°" + joueurConcerne + " est tombé sur la case tête de mort. Adieux petite oie, tu retournes à la case départ.");
      return tableauJoueur[joueurConcerne]=0;
    default :
      return tableauJoueur[joueurConcerne];
    }
}


boolean[] init_tableau_firstPlay(int nbDeJoueurs){
   boolean[] tableauFirstPlay = new boolean[nbDeJoueurs];
   for(int i=0; i<nbDeJoueurs; i++){
     tableauFirstPlay[i] = true;
   }     
   return tableauFirstPlay;
}


boolean[] init_tableau_canIPlay(int nbDeJoueurs){
   boolean[] tableau_canIPlay = new boolean[nbDeJoueurs];
   for (int i=0; i<nbDeJoueurs ; i++){
     tableau_canIPlay[i]= true;
   }
   return tableau_canIPlay;
}


int[] inittab_plateau(int nbDeCase, int largeurCases) {
 int[] insidetab_plateau = new int[nbDeCase];
 for (int i=0 ; i<insidetab_plateau.length ; i++){
   insidetab_plateau[i]=i*largeurCases+largeurCases/2; 
  }
  return insidetab_plateau; 
}


void dessiner_tab_plateau (int[] tab_plateau, int hauteur_case , int largeur_case) {  
  for (int i=1 ; i<tab_plateau.length ; i++) {
    
    if (i==42){
      fill(255, 165,0);
    } else if (i==52 || i==3) {
      fill(130, 130, 130);
    }else if (i==19) {
      fill(13, 156, 161);
    }else if (i==58) {
      fill(161, 38, 13);
    } else if (i==9 ||i==18 ||i==27 ||i==36 ||i==45 ||i==54){
      fill(65, 122, 64);
    }else {
      fill(250, 250, 250);
    }
    rect( tab_plateau[i], 80, largeur_case, hauteur_case);
    fill(0);
    textAlign(CENTER, CENTER);
    text(i, tab_plateau[i], hauteur_case);
  }
}
