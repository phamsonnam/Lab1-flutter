class Product {
  final int id;
  final String name;
  final String image;
  final double price;

  /// Phương thức khởi tạo thường (runtime).
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  /// Phương thức khởi tạo const (compile-time constant khi dùng với const).
  const Product.constProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  /// Factory map JSON → Product.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'price': price,
      };

  Product copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  @override
  String toString() =>
      'Product(id: $id, name: $name, image: $image, price: $price)';
}
