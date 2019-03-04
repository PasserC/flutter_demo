import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_fluter/Constant.dart';
import 'package:hello_fluter/ui/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var _account = "";
  var _password = "";
  var _isRememberPsd = false;


  ///提交登录信息
  void submitLogin() {
    if (_account != "" && _password != "") {
      showToast(
          context,
          "登录成功！\n account:" +
              _account +
              "\n password" +
              _password);
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) {
           return new HomePage();
          }));
      ///share存储账号密码
    } else {
      showToast(context, "请输入账号密码");
    }
  }

  TextEditingController getAccountController() {
    final controller = new TextEditingController();
    controller.addListener(() {
      _account = controller.text;
    });
    return controller;
  }

  TextEditingController getPsdController() {
    final controller = new TextEditingController();
    controller.addListener(() {
      _password = controller.text;
    });
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //LOGO
          Image.asset(
            'images/logo.png',
            height: 100,
            width: 100,
            scale: 2.0,
          ),
          Text(
            "元通成品物流",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ColorConstant.mainColor, fontSize: 35),
          ),

          ///账号输入框
          Container(
              margin: const EdgeInsets.only(
                top: 25,
              ),
              width: 220,
              child: new TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: getAccountController(),
                onFieldSubmitted: (value) {
                  _account = value;
                },
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: ColorConstant.textGrey,
                    ),
                    hintText: '请输入账号',
                    labelStyle: new TextStyle(
                      color: ColorConstant.textGrey,
                      fontSize: 16,
                    ),
                    labelText: '账号',
                    hintStyle: new TextStyle(
                      color: ColorConstant.textGrey,
                      fontSize: 16,
                    ),
                    border: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                        color: ColorConstant.textGrey,
                      ),
                    )),
              )),

          ///密码输入框
          Container(
              width: 220,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('^[a-z0-9A-Z]+\$'))
                ],
                controller: getPsdController(),
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: ColorConstant.textGrey,
                    ),
                    hintText: '请输入密码',
                    labelStyle: new TextStyle(
                      color: ColorConstant.textGrey,
                      fontSize: 16,
                    ),
                    labelText: '密码',
                    hintStyle: new TextStyle(
                      color: ColorConstant.textGrey,
                      fontSize: 16,
                    ),
                    border: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                        color: ColorConstant.textGrey,
                      ),
                    )),
              )),

          ///记住密码&忘记密码
          Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: 260,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _isRememberPsd,
                        onChanged: (bool newValue) {
                          setState(() {
                            ///share存储
                            _isRememberPsd = newValue;
                          });
                        },
                        activeColor: ColorConstant.mainColor,
                      ),
                      Text(
                        "记住密码",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    "忘记密码?",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),

          ///登录按钮
          Container(
              margin: const EdgeInsets.only(
                top: 50,
              ),
              width: 220,
              child: CupertinoButton(
                child: Text(
                  '登  录',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: ColorConstant.mainColor,
                disabledColor: ColorConstant.disabledColor,
                onPressed: () {
                  submitLogin();
                },
              )),
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
        builder: (BuildContext context) =>
            Positioned(
              //top值，可以改变这个值来改变toast在屏幕中的位置
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 6 / 7,
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
