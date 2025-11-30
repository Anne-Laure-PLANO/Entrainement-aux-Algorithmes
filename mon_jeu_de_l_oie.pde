// ce projet présente encore quelques problèmes de codage, qui sont en cours de résolution

int[]tab_plateau;
int largeurCases = 23;
int hauteurCases = 80;
int nbreDeCases = 64;
int joueurActuel = 0;
boolean[] tab_canIPlay; 
boolean[] tab_firstPlay;
int nbDeJoueurs = 3;
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
  println("tour du joueur : " + int(joueurActuel));
  boolean joueurFirstPlay = testFirstPlay(tab_firstPlay, joueurActuel);
  if(joueurFirstPlay){
    tab_firstPlay[joueurActuel] = false;
  }
  
  //test si le joueur peut jouer, sinon s'il a des points de tour de pénalité. si oui, on décrémente.
  if (!tab_canIPlay[joueurActuel]){ 
    if (tab_penaliteJoueurs[joueurActuel] >0) {
      tab_penaliteJoueurs[joueurActuel] -=1;
      if (tab_penaliteJoueurs[joueurActuel]==0){
        tab_canIPlay[joueurActuel]=true;
      }
    }
    joueurActuel = nextPlayer(joueurActuel, nbDeJoueurs);

    redraw();
  }
  
  tab_positionJoueurs[joueurActuel] = lancerDes_et_calculNouvellePosition(tab_positionJoueurs, joueurActuel, tab_plateau, joueurFirstPlay, tab_canIPlay);
  
  
  tab_canIPlay = isAVictory (joueurActuel, tab_canIPlay, nbDeJoueurs );
  afficherJoueurs( tab_positionJoueurs, tab_plateau, hauteurCases, nbDeJoueurs);
  tab_canIPlay = isAVictory (tab_positionJoueurs[joueurActuel], tab_canIPlay, nbDeJoueurs );
  joueurActuel = nextPlayer(joueurActuel, nbDeJoueurs);
  noLoop();

}

void mouseClicked(){
 redraw(); 
  
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

boolean testFirstPlay (boolean[] tab_isFirstPlay, int joueurConcerne){
  if (tab_isFirstPlay[joueurConcerne]){
    return true;
  }else {
    return false;
}
}

boolean[] isAVictory (int positionJoueur, boolean[] canIPlay, int nbDeJoueurs ){
  if (positionJoueur==63) {
    fill(255,0,0);
    textSize(128);
    text("Jeu fini, bravo au gagnant !", 900, 150);
    for (int i = 0 ;1< nbDeJoueurs ; i++){
      canIPlay[i] = false;
    }
  }
  return canIPlay;
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
  if (valeurDe1==6 && valeurDe2==3 || valeurDe1==3 && valeurDe2==6){
    listeJoueurs[joueurConcerne]=26;
  }else if (valeurDe1==4 && valeurDe2==5 || valeurDe1==5 && valeurDe2==4) {
    listeJoueurs[joueurConcerne]=53;
  }else if (sommeDes==6) {
    listeJoueurs[joueurConcerne]=12;
  }
  return listeJoueurs[joueurConcerne];
}
  

int lancerDes_et_calculNouvellePosition (int[] Score_Joueurs, int joueur, int [] tab_plateau, boolean isPremierTour, boolean[] tab_canIPlay) {
  int positionInitialeJoueur = Score_Joueurs[joueur];
  int valeur_de1 = (int)random(1, 7);
  println("valeur du dé n°1 : "+ valeur_de1);
  int valeur_de2 = (int)random(1, 7);
  println("valeur du dé n°2 : "+ valeur_de2);
  int total_des = valeur_de1 + valeur_de2;
  println("total des dés : "+total_des);
  if (isPremierTour){
    Score_Joueurs[joueur]= conditionPremierTour (valeur_de1, valeur_de2, total_des, joueur, Score_Joueurs);
  } 
  
  Score_Joueurs[joueur] = testsipositionEstDoubleValeurDes (Score_Joueurs, joueur, total_des); //pour cases compte double
  
  if (Score_Joueurs[joueur]> tab_plateau.length-1) {
    Score_Joueurs[joueur] = 63 - (Score_Joueurs[joueur] - 63);
  }
  tab_canIPlay[joueur] = ifPositionIsLockedCase (Score_Joueurs, joueur, tab_canIPlay);

  Score_Joueurs[joueur] = ifPositionIsSpecialCase (Score_Joueurs, joueur, total_des);
  Score_Joueurs = verifierSiPositionDejaOccupee (Score_Joueurs, joueur, positionInitialeJoueur);
  
  println("score du joueur : " + Score_Joueurs[joueur]);
  return Score_Joueurs[joueur];
}





int[] verifierSiPositionDejaOccupee (int[]liste_score_joueurs, int positionJoueurConcerne, int positionInitialeJoueurConcerne){
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


int testsipositionEstDoubleValeurDes (int[] tableauJoueur, int joueurConcerne, int total_des) {
  if ((tableauJoueur[joueurConcerne] == 9) ||(tableauJoueur[joueurConcerne] == 18) || (tableauJoueur[joueurConcerne] == 27) || (tableauJoueur[joueurConcerne] ==36) || (tableauJoueur[joueurConcerne] ==45) ||  (tableauJoueur[joueurConcerne] ==54)) {
    tableauJoueur[joueurConcerne] += total_des;
    println("le joueur est tombé sur une oie, la valeur des dés est doublée.");
    
    tableauJoueur[joueurConcerne] = testsipositionEstDoubleValeurDes(tableauJoueur, joueurConcerne, total_des);
  }
  else if (tableauJoueur[joueurConcerne]> 63) {
    tableauJoueur[joueurConcerne] = 63 - (tableauJoueur[joueurConcerne] - 63);
  }
  return tableauJoueur[joueurConcerne];
}

boolean ifPositionIsLockedCase (int[]tableauJoueur, int joueurConcerne, boolean[] tableauCanIPlay){
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

int ifPositionIsSpecialCase (int[] tableauJoueur, int joueurConcerne, int total_des) {
  switch (tableauJoueur[joueurConcerne]){      
    case 42 :
      println("Le joueur n°" + joueurConcerne + " s'est perdu dans le labyrinthe. Il retourne à la case 30.");
      return tableauJoueur[joueurConcerne]=30;
    case 58 :
      println("Le joueur n°" + joueurConcerne + " est tombé sur la case tête de mort. Adieux petite oie, tu retournes à la case départ.");
      return tableauJoueur[joueurConcerne]=0;
    default :
    }
  return tableauJoueur[joueurConcerne] + total_des;
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
