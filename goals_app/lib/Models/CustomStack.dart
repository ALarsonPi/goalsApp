class CustomStack<E> {
  final _list = List.empty(growable: true);

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get top => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
