import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_fluter/Constant.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  var _isOrder = false;

//  TextEditingController getAccountController() {
//    final controller = new TextEditingController();
//    controller.addListener(() {
//      _account = controller.text;
//    });
//    return controller;
//  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.headset,
                color: ColorConstant.textGrey,
                size: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "张无忌司机",
                    style: TextStyle(color: ColorConstant.textGrey),
                  ),
                  Text(
                    "未绑定车辆",
                    style:
                        TextStyle(color: ColorConstant.textGrey, fontSize: 13),
                  ),
                ],
              ),
              Text(
                "停止接单了",
                style: TextStyle(color: ColorConstant.errorColor),
              ),
              Row(
                children: <Widget>[
                  Text("开始接单"),
                  Switch(
                      value: _isOrder,
                      onChanged: (bool) {
                        _isOrder = bool;
                      })
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //吐司TOAST
  void showToast(BuildContext context, var msg) async {
    Widget _buildToastWidget() {
      return Center(
        child: Card(
          color: Colors.black26,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    //创建OverlayEntry
    OverlayEntry _overlayEntry = OverlayEntry(
        //toast靠它加到屏幕上
        builder: (BuildContext context) => Positioned(
              //top值，可以改变这个值来改变toast在屏幕中的位置
              top: MediaQuery.of(context).size.height * 6 / 7,
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: _buildToastWidget(),
                  )),
            ));
    //显示到屏幕上。
    overlayState.insert(_overlayEntry);
    //等待2秒
    await Future.delayed(Duration(seconds: 2));
    //移除
    _overlayEntry.remove();
  }
}
