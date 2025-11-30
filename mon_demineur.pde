int taillePlateauX = 10;
int taillePlateauY = 10;
int nbMine = 25;
int[][] plateauDemineur = new int[taillePlateauX][taillePlateauY];


void setup() {
   initBoard();
 
   getMines();       // incrémentation cases pour milieu du tableau
    
   printJeu();       //pour printer le jeu en fonction de la nature des cases
}

//initialise le plateau
void initBoard () {
  int minePosee = 0;
  int mineX = 0;
  int mineY = 0;
  for (int i=0; i<taillePlateauX ; i++) {
    for (int j=0; j<taillePlateauY ; j++){
    plateauDemineur[i][j] = 0; 
    }
  }
   //incrémentation des bombes
  while (minePosee<nbMine) {
   mineX = (int)random(0, taillePlateauX);
   mineY = (int)random(0, taillePlateauY);
    if (plateauDemineur[mineX][mineY] !=99) {
     plateauDemineur[mineX][mineY] = 99;
     minePosee+=1;
     }
  }
}

//intégré dans getMines() => identifie si la case concernée contient une bombe
boolean isAMine(int x, int y){  
   if (plateauDemineur[x][y]==99) {
   return true;
   } else { 
   return false;
   }
}

//incrémente le tableau en fonction de la présence des bombes
 void getMines (){
  for (int x=0 ; x<taillePlateauX ; x++) {
    for(int y=0 ; y<taillePlateauY ; y++) {
     boolean caseMine = isAMine(x,y);
     if (caseMine){
       for (int dx = -1 ; dx < 2 ; dx++){ //on créé un "mini-tableau" pour parcourir les valeurs autour de la bombe
         for (int dy = -1; dy < 2 ; dy++){
           if (dx == 0 && dy == 0) {     //on exclue la case où il y a la bombe.
             continue;                  //sert à passer à la boucle suivante.
           }
           int nx = x + dx;    // on applique le mini-tableau sur le tableau
           int ny = y + dy;
           
           if (nx>=0 && nx<taillePlateauX && ny>=0 && ny<taillePlateauY){ //on vérifie que le mini-tableau ne sorte pas du tableau
             if (plateauDemineur[nx][ny] !=99) {
             plateauDemineur[nx][ny] +=1;
             }
           }
         }
       }         
     }
   }
 }
}
 //imprime le jeu dans la console en fonction de la nature des cases.
 void printJeu() {
   for (int n=0 ; n<taillePlateauX ; n++) {
     for(int o=0 ; o<taillePlateauY ; o++){
       if (plateauDemineur[n][o]==99) {
         fill(255, 0, 0);
         print(" X ");
       } else {
         fill(255);
         print(" " + plateauDemineur[n][o] + " ");
       }
     }
   println("");  
 }
 }    
