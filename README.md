
Ejercicio 3:

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
