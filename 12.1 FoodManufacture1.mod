// Definicje zbiorów
range Months = 1..6;
{string} Oils = {"VEG1", "VEG2", "OIL1", "OIL2", "OIL3"};
{string} VegOils = {"VEG1", "VEG2"};
{string} NonVegOils = {"OIL1", "OIL2", "OIL3"};

// Parametry
float Price[Oils][Months] = ...;
float Hardness[Oils] = ...;
float RevenuePerTon = 150;
float StorageCost = 5;

// Zmienne decyzyjne
dvar float+ Buy[Oils][Months];   // Ile kupujemy
dvar float+ Use[Oils][Months];   // Ile zużywamy do produkcji
dvar float+ Store[Oils][0..6];   // Ile zostaje w magazynie (0 to stan początkowy)

// Cel: Maksymalizacja zysku
maximize sum(m in Months) (
    (sum(o in Oils) Use[o][m] * RevenuePerTon) - 
    (sum(o in Oils) Buy[o][m] * Price[o][m]) - 
    (sum(o in Oils) Store[o][m] * StorageCost)
);

// Ograniczenia
subject to {
  forall(m in Months) {
    // 1. Limity rafinacji
    sum(o in VegOils) Use[o][m] <= 200;
    sum(o in NonVegOils) Use[o][m] <= 250;
    
    // 2. Bilans magazynowy: co było + co kupiliśmy = co zużyliśmy + co zostało
    forall(o in Oils) {
      Store[o][m-1] + Buy[o][m] == Use[o][m] + Store[o][m];
    }
    
    // 3. Twardość produktu (średnia ważona)
    sum(o in Oils) Hardness[o] * Use[o][m] >= 3 * sum(o in Oils) Use[o][m];
    sum(o in Oils) Hardness[o] * Use[o][m] <= 6 * sum(o in Oils) Use[o][m];
    
    // 4. Limit magazynu
    forall(o in Oils) Store[o][m] <= 1000;
  }
  
  // 5. Stany początkowe i końcowe (500 ton)
  forall(o in Oils) {
    Store[o][0] == 500;
    Store[o][6] == 500;
  }
}
