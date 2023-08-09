extension StringExtension on String {
  // Replace first character to uppercase in all words in a string (e.g. 'new york' -> 'New York')
  String capitalize() {
    return split(' ')
        .map((str) => str[0].toUpperCase() + str.substring(1))
        .join(' ');
  }
}
