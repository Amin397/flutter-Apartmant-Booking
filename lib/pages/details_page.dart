import 'package:bookingapartmant/core/const.dart';
import 'package:bookingapartmant/models/apartment_model.dart';
import 'package:bookingapartmant/widgets/custom_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class DetailsPage extends StatefulWidget {
  final ApartmentModel data;

  DetailsPage(this.data);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var _pageController = PageController();
  var _currentIndex = 0;
  var _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _buildImageSlider(context),
          _buildWidgetImageIndicator(),
          _buildWidgetButtonClose(),
          _buildWidgetPrice(),
          _buildWidgetScroll(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .1,
        right: MediaQuery.of(context).size.width * .1 ,
        bottom: 14.0),
        child: CustomSliderWidget(),
      ),
    );
  }

  Widget _buildWidgetScroll(){
    return DraggableScrollableSheet(
      initialChildSize: .5,
      minChildSize: .5,
      maxChildSize: .8,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.drag_handle,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        widget.data.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildWidgetSize(
                              "Living Room", widget.data.sizeLivingRoom),
                          Container(
                            width: 2.0,
                            height: 50.0,
                            color: Colors.black54,
                          ),
                          _buildWidgetSize(
                              "Bath Room", widget.data.sizeBathRoom),
                          Container(
                            width: 2.0,
                            height: 50.0,
                            color: Colors.black54,
                          ),
                          _buildWidgetSize(
                              "Bed Room", widget.data.sizeBedRoom),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        widget.data.desc,
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            (_maxLines == 3) ? _maxLines = 10 : _maxLines = 3;
                          });
                        },
                        child: Text(
                          (_maxLines == 3) ? "Read More" : "Read Less",
                          style: TextStyle(color: AppColors.stylecolor,height: 1.5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment:Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.favorite , color: Colors.red,),
                    elevation: 3.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWidgetSize(String name, int size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "$size sqft",
          style: TextStyle(fontSize: 16.0, color: Colors.black38, height: 1.5),
        )
      ],
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .55,
      child: PageView.builder(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          itemCount: widget.data.images.length,
          itemBuilder: (context, index) {
            return Image.asset(
              "assets/images/${widget.data.images[index]}.jpg",
              fit: BoxFit.cover,
            );
          }),
    );
  }

  Widget _buildWidgetImageIndicator() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .45),
        child: SliderIndicator(
          length: widget.data.images.length,
          activeIndex: 0,
          animationDuration: Duration(milliseconds: 300),
          indicator: Icon(
            Icons.radio_button_unchecked,
            color: Colors.white,
            size: 10.0,
          ),
          activeIndicator: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetButtonClose() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildWidgetPrice() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      margin: EdgeInsets.only(left: 24.0, top: 50.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.euro_symbol,
            size: 16.0,
            color: Colors.white,
          ),
          Text(
            "${widget.data.price.toInt()}",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "/month",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
