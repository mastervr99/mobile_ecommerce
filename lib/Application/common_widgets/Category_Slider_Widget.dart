import 'dart:math';

import 'package:flutter/material.dart';

class Category_Slider_Widget extends StatefulWidget {
  @override
  _Category_Slider_Widget_State createState() =>
      _Category_Slider_Widget_State();
}

class _Category_Slider_Widget_State extends State<Category_Slider_Widget> {
  var categories = [
    {
      'category_name': 'Women',
      'category_image': "assets/images/women.jpg",
    },
    {
      'category_name': 'Men',
      'category_image': "assets/images/men.jpg",
    },
    {
      'category_name': 'Tshirts',
      'category_image': "assets/images/tshirts.jpg",
    },
    {
      'category_name': 'Shorts',
      'category_image': "assets/images/shorts.jpg",
    },
    {
      'category_name': 'Jeans',
      'category_image': "assets/images/jeans.jpg",
    },
    {
      'category_name': 'Leggins',
      'category_image': "assets/images/leggings.jpg",
    },
    {
      'category_name': 'Jackets',
      'category_image': "assets/images/jackets.jpg",
    },
    {
      'category_name': 'Trousers',
      'category_image': "assets/images/trousers.jpg",
    },
    {'category_name': 'Shoes', 'category_image': "assets/images/shoes.jpg"}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Nos Catégories',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 15,
            child: Container(),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 30,
                child: Container(
                    // color: Color(0xFFf5f6f7),
                    ),
              ),
              itemBuilder: (context, index) {
                return buildItem(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  buildItem(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.height / 11,
      child: ListView(
        children: [
          GestureDetector(
            child: Column(
              children: [
                Image.asset(
                  categories[index]['category_image']!,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Text(
                  categories[index]['category_name']!,
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
