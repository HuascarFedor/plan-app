class ListUtils {
  static String checkForDuplicates(Iterable<String> items, String text) {
    final duplicateCount = items.where((item) => item.contains(text)).length;
    if (duplicateCount > 0) {
      text += '${duplicateCount + 1}';
    }
    return text;
  }
}
