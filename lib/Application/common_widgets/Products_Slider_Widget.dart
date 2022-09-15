import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/components/Products_Grid_Tiles_Component.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

class Products_Slider_Widget extends StatefulWidget {
  List<Product> products;
  String title;

  Products_Slider_Widget(
      {Key? key, required this.products, required this.title})
      : super(key: key);

  @override
  _Products_Slider_Widget_State createState() =>
      _Products_Slider_Widget_State();
}

class _Products_Slider_Widget_State extends State<Products_Slider_Widget> {
  late PageController _pageController;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.fade,
                      //     child: ProductList(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: PageView.builder(
                itemCount: widget.products.length,
                pageSnapping: true,
                padEnds: false,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Products_Grid_Tiles_Component(
                      name:
                          widget.products[pagePosition].getTitle().length <= 30
                              ? widget.products[pagePosition].getTitle()
                              : widget.products[pagePosition]
                                      .getTitle()
                                      .substring(0, 30) +
                                  '...',
                      imageUrl: widget.products[pagePosition].getImageUrl(),
                      product: widget.products[pagePosition],
                      price:
                          widget.products[pagePosition].getPrice().toString(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
