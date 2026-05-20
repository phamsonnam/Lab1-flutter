import 'package:lab1flutter/product.dart';
import 'package:lab1flutter/product_dao.dart';

/// Giữ tương thích Lab 1 — ủy quyền cho [ProductDAO].
class ProductStore {
  ProductStore._();

  static List<Product> get products => ProductDAO.products;

  static SortMode get sortMode => ProductDAO.sortMode;

  static String displayAll() => ProductDAO.displayAll();

  static void add(Product product) => ProductDAO.add(product);

  static bool removeById(int id) => ProductDAO.removeById(id);

  static bool update(Product updated) => ProductDAO.edit(updated);

  static Product? findById(int id) => ProductDAO.findById(id);

  static List<Product> searchByName(String query) =>
      ProductDAO.searchByName(query);

  static List<Product> searchByPriceRange(double min, double max) =>
      ProductDAO.searchByPriceRange(min, max);

  static void sortByPrice({required bool ascending}) =>
      ProductDAO.sortByPrice(ascending: ascending);

  static void sortByName({required bool ascending}) =>
      ProductDAO.sortByName(ascending: ascending);

  static void sortById({bool ascending = true}) => ProductDAO.sortById();

  static void clearSort() => ProductDAO.clearSort();
}
