import 'package:amazon/UI/product_list.dart';
import 'package:amazon/UI/tab_drawer.dart';
import 'package:amazon/UI/top_bar.dart';
import 'package:amazon/models/global.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _pay() {
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-VDPgi1T73hDkhD6aOzET7A');
    InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
      onCardEntryCancel: _cardEntryCancel,
    );
  }

  void _cardEntryCancel() {}

  void _cardNonceRequestSuccess(CardDetails result) {
    print(result.nonce);

    InAppPayments.completeCardEntry(
      onCardEntryComplete: _onCardEntryComplete,
    );
  }

  void _onCardEntryComplete() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerTab()),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: dark_blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Image(
                          image:
                              AssetImage('lib/assets/amazon-logo-white.png')),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.mic, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      onPressed: _pay,
                      //child: Icon(Icons.card_travel),
                      icon: Icon(Icons.card_travel,color:Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                TopBar(),
                Container(
                  height: MediaQuery.of(context).size.height - 170,
                  child: ProductList(),
                )
              ],
            )));
  }
}
