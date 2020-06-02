import 'package:bookingapartmant/core/const.dart';
import 'package:bookingapartmant/models/apartment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = ApartmentModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Find your flat",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.stylecolor,
        unselectedItemColor: Colors.black38,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("Data")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "55 result in your area",
              style: TextStyle(color: Colors.black38),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsPage(data[index])));
                      },
                      child: _buildItems(context, index),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage(
                        "assets/images/${data[index].images.first}.jpg"),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                        color: Colors.black12)
                  ]),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black45,
                              Colors.black87
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.0, bottom: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * .2,
                            child: Text(
                              "${data[index].name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Icon(Icons.directions , color: Colors.white, size: 20.0,),
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                color: AppColors.stylecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildDescriptions(context, index),
        ],
      ),
    );
  }

  Widget _buildDescriptions(BuildContext context, int index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * .43,
        height: 200.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 7.0, spreadRadius: 1)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.euro_symbol,
                  size: 18.0,
                ),
                Text(
                  "${data[index].price.toInt()}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  " /month",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              "${data[index].sizeDesc}",
              style: TextStyle(color: Colors.black38),
            ),
            Row(
              children: <Widget>[
                RatingBar(
                  onRatingUpdate: (v) {},
                  initialRating: data[index].review,
                  itemSize: 12.0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  "${data[index].reviewCount.toInt()} , reviews",
                  style: TextStyle(color: Colors.black87, fontSize: 10.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                ...data[index].personImages.map((e) {
                  return Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        image: DecorationImage(
                            image: ExactAssetImage("assets/images/$e.jpg"))),
                  );
                }),
                Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: Colors.black26),
                  child: Center(
                    child: Text(
                      "23 +",
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ),
                )
              ],
            ),
            Wrap(
              children: <Widget>[
                ...data[index].features.map((features) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 6.0, right: 6.0),
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: AppColors.stylecolor,
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    child: Text(
                      features,
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
