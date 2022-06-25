class Product {
  String title;
  String description = '';

  Product(this.title);

  setDescription(String description) {
    this.description = description;
  }

  String getTitle() {
    return title;
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
