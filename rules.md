# Konkurs Brainfuck - zasady

1. Mam pisać definicje czy każdy wie kto to jest uczestnik?
1. Zadaniem uczestnika jest napisanie jak najszybszego interpretera brainfucka zgodnego z *link do specyfikacji*
    * Dopuszczalne odstępstwo: UB przy napotkaniu nieprawidłowych znaków
    * Typ komórki musi być u32, wypisywane wartości w zakresie ASCII jako ASCII, w przeciwnym razie dziesiątkowo
    * Pamięć musi mieć przynajmniej 30k komórek. Wyjście poza zakres jest ???UB
1. Kod musi być open source na licencji GPL, MIT lub kompatybilnej
1. Program będzie testowany za pomocą skryptu build.sh. Plik:
    * Musi przyjmować wejście na `stdin`.
    * Musi wypisywać wyjście na `stdout`. Nie może wypisywać niczego innego. Jeżeli chcesz wypisywać komunikaty debugowania, rób to na `stderr` lub ukryj pod flagą cmd.

1. Skrypt testujący będzie wykorzystywał do testowania programy z folderu `testcases/*.bf` i porównywał je z odpowiadającym mu plikiem `testcases/*.out`.
1. Wygrywa uczestnik, którego kod przejdzie wszystkie testy i będzie najszybszy.
1. Przegrani stawiają wygranemu piwo (lub coś podobnego).

Wymagana składnia build.sh (jest wykonywany w głównym folderze konkretnego interpretera):
```
#!/usr/bin/env -S bash ../../entry-include.sh

build() {
    # przygotowuje interpreter do pracy (np. kompiluje go)
}

run() {
    # uruchamia plik bf. To jest testowane i liczone do czasu.
}
```
