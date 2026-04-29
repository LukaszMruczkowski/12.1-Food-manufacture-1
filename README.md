# Food Manufacture I - CPLEX Optimization Project

Ten projekt zawiera rozwiązanie problemu optymalizacyjnego **12.1 Food Manufacture 1** z książki *Model Building in Mathematical Programming* (H. Paul Williams). Problem został rozwiązany przy użyciu języka OPL w środowisku IBM ILOG CPLEX Optimization Studio.

## Opis Problemu

Celem zadania jest opracowanie polityki zakupowej i produkcyjnej dla producenta żywności na okres 6 miesięcy (styczeń-czerwiec). Producent miesza pięć rodzajów surowych olejów (2 roślinne i 3 nieroślinne), aby uzyskać produkt końcowy.

### Kluczowe założenia:
* **Maksymalizacja zysku**: Przychód ze sprzedaży (£150/t) minus koszty zakupu surowców i koszty magazynowania (£5/t za miesiąc).
* **Ograniczenia rafinacji**: Max 200 ton olejów roślinnych i 250 ton pozostałych na miesiąc.
* **Magazynowanie**: Można przechowywać do 1000 ton każdego rodzaju oleju. Stan początkowy i wymagany stan końcowy to 500 ton każdego oleju.
* **Parametry technologiczne**: Twardość końcowego produktu musi mieścić się w przedziale od 3 do 6 (liczona jako średnia ważona twardości składników).

---

## Wyniki Optymalizacji

Model znalazł rozwiązanie optymalne globalnie.

* **Całkowity zysk (Objective):** £107 842,59
* **Status:** Optimal solution found.

### Główne wnioski z modelu:
1. **Pełne moce przerobowe:** Model w każdym miesiącu w pełni wykorzystuje limity rafinacji (łącznie 450 ton), co sugeruje wysoką rentowność produkcji przy obecnej cenie sprzedaży.
2. **Strategia magazynowa:** Zamiast kupować surowce co miesiąc, model optymalizuje zakupy, wykorzystując zapasy początkowe. Duże zakupy realizowane są dopiero w czerwcu, kiedy ceny wybranych olejów (np. OIL2 i VEG1) są najniższe, aby spełnić warunek 500 ton zapasu na koniec okresu.
3. **Zgodność technologiczna:** Twardość produktu końcowego została zachowana w każdym miesiącu w wymaganym zakresie [3, 6].

---

## Struktura Projektu

* `12.1 FoodManufacture1.mod`: Kod modelu w języku OPL (definicje zmiennych, funkcji celu i ograniczeń).
* `12.1 FoodManufacture1.dat`: Plik z danymi (ceny rynkowe olejów, twardości, parametry kosztowe).
