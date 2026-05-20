import 'package:lab1flutter/product.dart';

enum SortMode { none, priceAsc, priceDesc, nameAsc, nameDesc, idAsc }

class ProductDAO {
  ProductDAO._();

  static final List<Product> _products = [
    const Product.constProduct(
      id: 1,
      name: 'Laptop',
      image:
          'https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU',
      price: 15_990_000,
    ),
    const Product.constProduct(
      id: 2,
      name: 'Chuột không dây',
      image: 'https://picsum.photos/seed/lab1b/200',
      price: 350_000,
    ),
    const Product.constProduct(
      id: 3,
      name: 'Bàn phím cơ',
      image: 'https://picsum.photos/seed/lab1c/200',
      price: 2_190_000,
    ),
  ];

  static int _nextId = 4;
  static SortMode _sortMode = SortMode.none;

  static List<Product> get products => List.unmodifiable(_products);

  static SortMode get sortMode => _sortMode;

  static String displayAll() {
    if (_products.isEmpty) return '(trống)';
    return _products.map((p) => p.toString()).join('\n');
  }

  static void add(Product product) {
    int id;
    if (product.id > 0 && !_products.any((p) => p.id == product.id)) {
      id = product.id;
      if (id >= _nextId) _nextId = id + 1;
    } else {
      id = _nextId++;
    }
    _products.add(product.copyWith(id: id));
    _reapplySort();
  }

  static bool edit(Product product) {
    final i = _products.indexWhere((p) => p.id == product.id);
    if (i < 0) return false;
    _products[i] = product;
    _reapplySort();
    return true;
  }

  static bool removeById(int id) {
    final i = _products.indexWhere((p) => p.id == id);
    if (i < 0) return false;
    _products.removeAt(i);
    return true;
  }

  static Product? find(int id) => findById(id);

  static Product? findById(int id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Product> findAll() => List<Product>.from(_products);

  static List<Product> searchByName(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return findAll();
    return _products
        .where((p) => p.name.toLowerCase().contains(q))
        .toList(growable: false);
  }

  static List<Product> searchByPriceRange(double min, double max) {
    return _products
        .where((p) => p.price >= min && p.price <= max)
        .toList(growable: false);
  }

  static List<Product> searchByImage(String keyword) {
    final q = keyword.trim().toLowerCase();
    if (q.isEmpty) return findAll();
    return _products
        .where((p) => p.image.toLowerCase().contains(q))
        .toList(growable: false);
  }

  static List<Product> search({
    String? name,
    double? minPrice,
    double? maxPrice,
  }) {
    return _products.where((p) {
      if (name != null && name.trim().isNotEmpty) {
        if (!p.name.toLowerCase().contains(name.trim().toLowerCase())) {
          return false;
        }
      }
      if (minPrice != null && p.price < minPrice) return false;
      if (maxPrice != null && p.price > maxPrice) return false;
      return true;
    }).toList(growable: false);
  }

  /// Tăng giá mỗi sản phẩm [percent] (mặc định 10%) — dùng map khai báo.
  static void increasePrice({double percent = 0.1}) {
    final factor = 1 + percent;
    final updated = _products
        .map((p) => p.copyWith(price: p.price * factor))
        .toList();
    _products
      ..clear()
      ..addAll(updated);
    _reapplySort();
  }

  static void sortByPrice({required bool ascending}) {
    _sortMode = ascending ? SortMode.priceAsc : SortMode.priceDesc;
    _applySort();
  }

  static void sortByName({required bool ascending}) {
    _sortMode = ascending ? SortMode.nameAsc : SortMode.nameDesc;
    _applySort();
  }

  static void sortById({bool ascending = true}) {
    _sortMode = SortMode.idAsc;
    _applySort();
  }

  static void clearSort() {
    _sortMode = SortMode.none;
  }

  static void _applySort() {
    switch (_sortMode) {
      case SortMode.priceAsc:
        _products.sort((a, b) => a.price.compareTo(b.price));
      case SortMode.priceDesc:
        _products.sort((a, b) => b.price.compareTo(a.price));
      case SortMode.nameAsc:
        _products.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
      case SortMode.nameDesc:
        _products.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
      case SortMode.idAsc:
        _products.sort((a, b) => a.id.compareTo(b.id));
      case SortMode.none:
        break;
    }
  }

  static void _reapplySort() {
    if (_sortMode != SortMode.none) _applySort();
  }

  /// Thêm nhiều sản phẩm từ JSON (dùng factory Product.fromJson).
  static void addAllFromJson(List<Map<String, dynamic>> jsonList) {
    for (final json in jsonList) {
      add(Product.fromJson(json));
    }
  }
}
