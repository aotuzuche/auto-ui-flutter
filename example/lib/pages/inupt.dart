import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageInput extends StatefulWidget {
  @override
  _PageInputState createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Input Widget',
        onBackPressed: () => AtRouter.pop(context),
        border: AtBorder.Shadow,
      ),
      body: AtLayoutBody(
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        children: <Widget>[
//          AtCellTitle('基本使用'),
//          Container(
//            color: Colors.white,
//            padding: EdgeInsets.symmetric(
//              horizontal: r.px(40),
//              vertical: r.px(20),
//            ),
//            child: AtInput(
//              placeholder: '请输入内容',
//            ),
//          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                AtInput(
                  placeholder: '请输入',
                  onSaved: (String v) {
                    print(v);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: RaisedButton(
                    onPressed: login,
                    child: Text('submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    var f = _formKey.currentState;
    print('save');
    f.save();
  }
}
