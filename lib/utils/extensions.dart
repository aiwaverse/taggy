extension ListSorted<T> on List<T> {
  List<T> sorted([int Function(T, T)? compare]) {
    sort(compare);
    return this;
  }
}
