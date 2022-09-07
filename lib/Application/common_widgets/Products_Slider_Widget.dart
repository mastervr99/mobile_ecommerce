import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/components/Products_Grid_Tiles_Component.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

class Products_Slider_Widget extends StatefulWidget {
  List<Product> products;

  Products_Slider_Widget({Key? key, required this.products}) : super(key: key);

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
    _pageController = PageController(viewportFraction: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: PageView.builder(
          itemCount: widget.products.length,
          pageSnapping: true,
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
                name: widget.products[pagePosition].getTitle().length <= 30
                    ? widget.products[pagePosition].getTitle()
                    : widget.products[pagePosition]
                            .getTitle()
                            .substring(0, 20) +
                        '...',
                imageUrl: widget.products[pagePosition].getImageUrl(),
                product: widget.products[pagePosition],
                price: widget.products[pagePosition].getPrice().toString(),
              ),
            );
          }),
    );
  }
}
