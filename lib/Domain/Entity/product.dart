class Product {
  String title;
  String description = '';
  String colour = '';
  String gender = '';
  String category = '';
  String subCategory = '';
  String type = '';
  String usage = '';
  String imageUrl = '';

  Product(this.title);

  setDescription(String description) {
    description = description;
  }

  setColor(String color) {
    colour = color;
  }

  setGender(String gender) {
    gender = gender;
  }

  setCategory(String category) {
    category = category;
  }

  setSubCategory(String subCategory) {
    subCategory = subCategory;
  }

  setType(String type) {
    type = type;
  }

  setUsage(String usage) {
    usage = usage;
  }

  setImageUrl(String imageUrl) {
    imageUrl = imageUrl;
  }

  String getTitle() {
    return title;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'colour': colour,
      'gender': gender,
      'category': category,
      'subCategory': subCategory,
      'type': type,
      'usage': usage,
      'imageUrl': imageUrl
    };
  }
}
