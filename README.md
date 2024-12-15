# Ejercicio 1 
### Se requiere realizar la arquitectura de una aplicación del tipo red social, los usuarios podrán enviar fotos a su perfil, ver otros perfiles, realizar videos… Propón las librerías (Preferiblemente Dart, se pueden mencionar librerías de Kotlin o Swift) y qué organización de código utilizaras para cumplir los principios SOLID y conseguir un código limpio - no utilizar más de una página.

# Solucion 1 

Para la aplicación de red social, propongo utilizar la arquitectura MVVM con BlocProvider para la gestión del estado, siguiendo los principios SOLID para garantizar un diseño limpio y escalable. Este enfoque asegura una separación clara de responsabilidades y facilita la mantenibilidad

Estructura de carpetas:
```
lib/
├── models/ # Modelos de datos como User, Post, Video, etc.
├── viewmodels/ # Clases BLoC para la gestión de estados (e.g., user_bloc.dart, video_bloc.dart)
├── views/ # Componentes de la interfaz de usuario (pantallas y widgets)
├── services/ # Servicios como la integración con APIs y el manejo de FFmpeg
├── widgets/ # Widgets reutilizables como botones y tarjetas
```

Las principales bibliotecas a utilizar incluyen:

	•	flutter_bloc para gestionar el estado de la aplicación.
	•	image_picker para manejar la selección de fotos y videos.
 	•	camera para la creacion de nuevas fotos y videos.
	•	ffmpeg_kit_flutter para el procesamiento y optimización de videos.
	•	http para la comunicación con APIs y la recuperación de datos.

# Ejercicio 2
### En este ejercicio puedes descargar el código del siguiente repositorio: https://github.com/leadtechcorp/flutter-state-test. Como puedes ver al ejecutarlo tenemos varios widgets montando dos matrioskas. Lo que tenemos que conseguir es que el boton ‘+’ aumente el número que tiene la matrioska inferior. Las condiciones a cumplir son: 
- Solo puedes cambiar tener 1 nuevo StatefulWidget en el proyecto (es decir, convertir un stateless a stateful).
-  Puedes añadir tantas variables/constantes, constructores, parámetros/argumentos como necesites. 
- Solo puedes añadir una función (si necesitas más justificarlo). 
- No puedes crear nuevas clases que hereden de StatefulWidget ni StatelessWidget (lógicamente al cambiar a Stateful si puedes tener la clase asociada). 
- NO PUEDES USAR NINGÚN PAQUETE.

# Solucion 2

El mayor cambio se hizo en la clase CounterFirstWidget. El codigo restante se encuentra en este repo

```dart
import 'package:flutter/material.dart';
import 'counter_widget.dart';

class CounterFirstWidget extends StatefulWidget {
  const CounterFirstWidget({Key? key}) : super(key: key);

  static void Function()? incrementCounter; // Nullable static reference to increment function

  @override
  _CounterFirstWidgetState createState() => _CounterFirstWidgetState();
}

class _CounterFirstWidgetState extends State<CounterFirstWidget> {
  int _counter = 28;

  @override
  void initState() {
    super.initState();
    // Set the static method to increment the counter
    CounterFirstWidget.incrementCounter = _incrementCounter;
  }

  // Method to increment the counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent[200],
      child: CounterWidget(counter: _counter), // Display the updated counter
    );
  }
}
```

# Ejercicio 3
### Considera una matriz de letras como la de la imágen (de tamaño variable), y una lista de palabras (de tamaño variable también). Se pide diseñar un algoritmo que devuelva una lista de palabras que se formar con las letras del tablero, teniendo en cuenta la siguiente restricción: 
- Las letras de las palabras deben formar una cadena (cada letra debe estar adyacente - ortogonal o diagonalmente - con la siguiente. 
- Cada letra sólo se puede recorrer una vez por palabra. 

En la imágen de ejemplo vemos la palabra leadtech 

<img width="464" alt="Screenshot 2024-12-15 at 14 06 46" src="https://github.com/user-attachments/assets/d31bd179-8c9c-4c62-b411-cec1a9717aaf" />


Se debe entregar una función en Dart/Swift/Kotlin que siga una cabecera similar a la siguiente (ejemplo en Dart): 
```

List<String> findWords(List<List<String>> matrix, List<String> words); Parámetros de ejemplo: 
List<List<String>> matrix = [ 
['a', 'e', 't', 'l'], 
['d', 'a', 'e', 'u'], 
['t', 'e', 'a', 'r'], 
['c', 'h', 'x', 'g'], 
]; 
List<String> words = [ 
'leadtech', 
'notleadtech', 
'potato', 
'anotherCompany', 
'great', 
];
Output: 
['leadtech', 'great']
```

# Solucion 2

Complejidad temporal:
- Construcción del Trie: O(W * L), donde W es el número de palabras y L su longitud promedio.
- Búsqueda DFS: O(R * C * 4^L), donde R y C son las dimensiones de la matriz y L la longitud de la palabra más larga.

Complejidad espacial:
- Espacio para el Trie: O(W * L).
- Pila de recursión y conjunto de visitados: O(L + R * C).

```dart
class TrieNode {
  Map<String, TrieNode> children =
      {}; // Almacena los nodos hijos para cada carácter
  bool isWord =
      false; // Marca si el nodo representa el final de una palabra válida
}

class Trie {
  final TrieNode root = TrieNode();

  // Inserta una palabra en el Trie
  void insert(String word) {
    TrieNode node = root;
    for (String char in word.split('')) {
      if (!node.children.containsKey(char)) {
        node.children[char] =
            TrieNode(); // Agrega un nuevo nodo si el carácter no existe
      }
      node = node.children[char]!; // Avanza al nodo hijo
    }
    node.isWord = true; // Marca el final de la palabra
  }
}

List<String> findWords(List<List<String>> matrix, List<String> words) {
  int rows = matrix.length;
  int cols = matrix[0].length;

  // Construye el Trie usando la lista de palabras proporcionada
  Trie trie = Trie();
  for (String word in words) {
    trie.insert(word);
  }

  Set<String> result =
      {}; // Para almacenar las palabras únicas encontradas en la matriz
  Set<String> visited =
      {}; // Para rastrear las celdas visitadas durante la búsqueda DFS

  // Direcciones para moverse en la matriz (ortogonales y diagonales)
  List<List<int>> directions = [
    [-1, 0], [1, 0], [0, -1], [0, 1], // Arriba, Abajo, Izquierda, Derecha
    [-1, -1],
    [-1, 1],
    [1, -1],
    [
      1,
      1
    ] // Superior Izquierda, Superior Derecha, Inferior Izquierda, Inferior Derecha
  ];

  // Función de Búsqueda en Profundidad (DFS)
  void dfs(int row, int col, TrieNode node, String word) {
    // Detener si estamos fuera de los límites o si la celda ya fue visitada
    if (row < 0 ||
        row >= rows ||
        col < 0 ||
        col >= cols ||
        visited.contains("$row,$col")) {
      return;
    }

    String char = matrix[row][col];

    // Detener si el carácter actual no es un prefijo válido en el Trie
    if (!node.children.containsKey(char)) {
      return;
    }

    // Avanza al nodo hijo en el Trie
    TrieNode childNode = node.children[char]!;
    String newWord = word + char; // Agrega el carácter actual a la palabra

    // Si el nodo actual marca el final de una palabra, agrégala al resultado
    if (childNode.isWord) {
      result.add(newWord);
    }

    // Marca la celda actual como visitada
    visited.add("$row,$col");

    // Explora todas las direcciones posibles
    for (List<int> direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];
      dfs(newRow, newCol, childNode, newWord);
    }

    // Retroceso: desmarca la celda actual como visitada
    visited.remove("$row,$col");
  }

  // Inicia la búsqueda DFS desde cada celda en la matriz
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      dfs(i, j, trie.root, "");
    }
  }

  // Devuelve la lista de palabras encontradas
  return result.toList();
}

// Ejemplo de uso
void main() {
  List<List<String>> matrix = [
    ['a', 'e', 't', 'l'],
    ['d', 'a', 'e', 'u'],
    ['t', 'e', 'a', 'r'],
    ['c', 'h', 'x', 'g'],
  ];
  List<String> words = [
    'leadtech',
    'notleadtech',
    'potato',
    'anotherCompany',
    'great',
  ];

  print(findWords(
      matrix, words)); // Expected Output: ['lead', 'tear', 'ear', 'cat']
}
