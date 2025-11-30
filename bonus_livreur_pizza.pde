int[] stockPizza = { 13, 11, 8, 7, 5, 3, 0 };
float totalCA = 0;

void setup () {
  for (int i=0; i<stockPizza.length-1 ; i++){
    println("livraison n°" + (i+1) + ". Mon stock de pizza est de " + stockPizza[i] + " pizza(s).");
    
    int nbPizza = nbPizzaVendues(i);  
    int fraisLivraison = calculeFraisLivraison(nbPizza);
    float prixTotal = calculePrix(nbPizza, fraisLivraison);
    totalCA = calculeCAJour(prixTotal);
    
    println("");
}

println("le chiffre d'affaires du jour est de " + totalCA );
println("J'ai fini mes livraisons, je rentre me coucher. ");

}

int nbPizzaVendues(int n) {
  return (stockPizza[n]-stockPizza[n+1]);
}
int calculeFraisLivraison(int nbPizza) {
  println("je vais livrer " + nbPizza + " pizza(s).");
  if (nbPizza >3) {
    return 0;
  } else {
    return 3;
  }
}

float calculePrix(int nbPizza, int Livraison ) {
  float prixPizza = 10;
  float prixTotal = nbPizza*prixPizza + Livraison;
  println("Les clients devront payer " + prixTotal + " euros.");
  return prixTotal;
}

float calculeCAJour(float prixTotal) {
  return totalCA += prixTotal;
}
