class Product {
  String title;
  String description = '';
  String color = '';
  String gender = '';
  String category = '';
  String subCategory = '';
  String type = '';
  String usage = '';
  String imageUrl = '';
  double price = 0;
  int sku = 0;

  Product(this.title);

  setDescription(String description) {
    this.description = description;
  }

  setColor(String color) {
    this.color = color;
  }

  setGender(String gender) {
    this.gender = gender;
  }

  setCategory(String category) {
    this.category = category;
  }

  setSubCategory(String subCategory) {
    this.subCategory = subCategory;
  }

  setType(String type) {
    this.type = type;
  }

  setUsage(String usage) {
    this.usage = usage;
  }

  setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  setPrice(double price) {
    this.price = price;
  }

  setSku(int sku) {
    this.sku = sku;
  }

  getTitle() {
    return title;
  }

  getImageUrl() {
    return imageUrl;
  }

  getDescription() {
    return description;
  }

  getColor() {
    return color;
  }

  getGender() {
    return gender;
  }

  getCategory() {
    return category;
  }

  getSubCategory() {
    return subCategory;
  }

  getType() {
    return type;
  }

  getUsage() {
    return usage;
  }

  getPrice() {
    return price;
  }

  getSku() {
    return sku;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'color': color,
      'gender': gender,
      'category': category,
      'subCategory': subCategory,
      'type': type,
      'usage': usage,
      'imageUrl': imageUrl,
      'price': price,
      'sku': sku
    };
  }
}
