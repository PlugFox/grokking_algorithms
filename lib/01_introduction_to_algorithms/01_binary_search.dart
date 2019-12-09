typedef Comparator<T> = int Function(T a, T b);

int binarySearch<T>(List<T> sortedList, T value, {Comparator<T> comparator, bool needToSort = false}) {
  if (needToSort) sortedList.sort();
  comparator ??= _defaultComparator;
  int min = 0;
  int max = sortedList.length;
  while (min < max) {
    int mid = min + ((max - min) >> 1);
    T element = sortedList[mid];
    int comp = comparator(element, value);
    if (comp < 0) {
      min = mid + 1;
    } else if (comp > 0) {
      max = mid;
    } else if (comp == 0) {
      return mid;
    } else {
      throw UnsupportedError('Unsupported compare result: ${comp.toString()}');
    }
  }
  return null;
}

int _defaultComparator<T>(T a, T b) =>
  (a is Comparable && b is Comparable)
    ? a.compareTo(b)
    : throw UnsupportedError('Unsupported type in compare function: ${T.toString()}');


void main() {
  print(binarySearch([1, 2, 3, 4, 5], 1));
  print(binarySearch([1, 2, 3, 4, 5], -1));
}