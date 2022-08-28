class Order_Item {
  String title;
  String order_reference = '';
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

  Order_Item(this.title);

  setDescription(String description) {
    this.description = description;
  }

  setOrderReference(String order_reference) {
    this.order_reference = order_reference;
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

  getOrderReference() {
    return order_reference;
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
      'sku': sku,
      'order_reference': order_reference
    };
  }
}
