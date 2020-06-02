import 'package:bookingapartmant/core/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomSliderWidget extends StatefulWidget {
  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  var _maxWidth = 0.0;
  var _width = 0.0;
  var _value = 0.0;
  var _booked = false;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        _maxWidth = constraint.maxWidth;
        return Container(

          decoration: BoxDecoration(
              color: _booked ? Colors.greenAccent : AppColors.stylecolor,
              borderRadius: BorderRadius.all(Radius.circular(50.0)
              ),
            border: Border.all(color: _booked ? Colors.greenAccent : AppColors.stylecolor , width: 3.0)
          ),
          height: 60.0,
          child: Stack(
            children: <Widget>[
              Center(
                child: Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white60 ,
                      Colors.black87 ,
                      Colors.white60,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                  ),
                  child: Text(
                    _booked ? "Booked" : "Slide to book",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              AnimatedContainer(
                width: _width <= 55 ? 55 : _width,
                duration: Duration(milliseconds: 150),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: _onDrag,
                      onVerticalDragEnd: _onDragEnd,
                      child: Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        child: Icon(Icons.keyboard_arrow_right , size: 30.0,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onDrag(DragUpdateDetails details){
    setState(() {
      _value = (details.globalPosition.dx) / _maxWidth;
      _width = _maxWidth * _value;
    });
  }

  void _onDragEnd(DragEndDetails details){
    _value > .65 ? _value = 1 : _value = 0 ;

    setState(() {
      _width = _maxWidth * _value;
      _booked = _value > .9 ;
    });
  }
}
