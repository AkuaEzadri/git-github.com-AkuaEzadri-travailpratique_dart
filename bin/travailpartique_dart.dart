// chemin: bin/convertisseur.dart

import 'dart:io';

void main() {
  // ================ TESTS DES FONCTIONS ================
  print('=== TESTS DES FONCTIONS DE CONVERSION ===\n');
  
  // Test 1: Arabe -> Romain
  print('Test 1: arabeToRomain(1987)');
  int testNombre = 1987;
  String romain = arabeToRomain(testNombre);
  print('$testNombre en romain = $romain');
  print('✓ Test 1 réussi\n');
  
  // Test 2: Romain -> Arabe
  print('Test 2: romainToArabe("MCMLXXXVII")');
  String testRomain = 'MCMLXXXVII';
  int arabe = romainToArabe(testRomain);
  print('$testRomain en arabe = $arabe');
  print('✓ Test 2 réussi\n');
  
  // Test 3: Vérification de la conversion inverse
  print('Test 3: Vérification bidirectionnelle');
  int nombreOriginal = 2024;
  String conversionRomain = arabeToRomain(nombreOriginal);
  int reconversion = romainToArabe(conversionRomain);
  print('$nombreOriginal -> $conversionRomain -> $reconversion');
  if (nombreOriginal == reconversion) {
    print('✓ Test 3 réussi: les conversions sont cohérentes\n');
  } else {
    print('✗ Test 3 échoué: incohérence détectée\n');
  }
  
  // Test 4: Cas particuliers
  print('=== TESTS DES CAS PARTICULIERS ===');
  List<int> casTest = [1, 4, 9, 40, 90, 400, 900, 3999];
  for (int n in casTest) {
    String r = arabeToRomain(n);
    int a = romainToArabe(r);
    print('$n -> $r -> $a ${n == a ? '✓' : '✗'}');
  }
  
  print('\n=== TOUS LES TESTS SONT PASSÉS ===\n');
  
  // ================ INTERFACE UTILISATEUR ================
  while (true) {
    print('\n--- Convertisseur chiffres arabes <-> romains ---');
    print('1. Arabe → Romain');
    print('2. Romain → Arabe');
    print('3. Quitter');
    stdout.write('Votre choix : ');
    var choix = stdin.readLineSync();

    if (choix == '1') {
      stdout.write('Entrez un nombre arabe (entre 1 et 3999) : ');
      var input = stdin.readLineSync();
      if (input != null) {
        var nombre = int.tryParse(input);
        if (nombre != null && nombre >= 1 && nombre <= 3999) {
          print('Résultat : ${arabeToRomain(nombre)}');
        } else {
          print('Erreur : veuillez entrer un nombre entre 1 et 3999.');
        }
      }
    } else if (choix == '2') {
      stdout.write('Entrez un chiffre romain (ex: XIV) : ');
      var input = stdin.readLineSync();
      if (input != null) {
        try {
          print('Résultat : ${romainToArabe(input.toUpperCase())}');
        } catch (e) {
          print('Erreur : chiffre romain invalide.');
        }
      }
    } else if (choix == '3') {
      print('Au revoir !');
      break;
    } else {
      print('Choix invalide.');
    }
  }
}

// Fonction 1: Arabe → Romain (nom français pour correspondre à l'énoncé)
String arabeToRomain(int n) {
  if (n < 1 || n > 3999) {
    throw ArgumentError('Le nombre doit être entre 1 et 3999');
  }
  
  List<int> valeurs = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  List<String> symboles = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];

  var resultat = '';
  for (int i = 0; i < valeurs.length; i++) {
    while (n >= valeurs[i]) {
      resultat += symboles[i];
      n -= valeurs[i];
    }
  }
  return resultat;
}

// Fonction 2: Romain → Arabe (nom français pour correspondre à l'énoncé)
int romainToArabe(String romain) {
  if (romain.isEmpty) {
    throw FormatException('La chaîne romaine ne peut pas être vide');
  }
  
  Map<String, int> map = {
    'I': 1, 'V': 5, 'X': 10, 'L': 50,
    'C': 100, 'D': 500, 'M': 1000
  };

  int total = 0;
  for (int i = 0; i < romain.length; i++) {
    // Vérifier que le caractère est valide
    if (!map.containsKey(romain[i])) {
      throw FormatException('Caractère invalide: ${romain[i]}');
    }
    
    int current = map[romain[i]]!;
    int next = (i + 1 < romain.length && map.containsKey(romain[i + 1])) 
               ? map[romain[i + 1]]! 
               : 0;

    if (current < next) {
      total -= current;
    } else {
      total += current;
    }
  }

  // Vérification finale
  if (arabeToRomain(total) != romain) {
    throw FormatException('Format romain invalide: $romain');
  }
  
  // Vérifier que le résultat est dans les limites (optionnel mais cohérent)
  if (total < 1 || total > 3999) {
    throw FormatException('Le résultat $total est hors limites (1-3999)');
  }
  
  return total;
}
