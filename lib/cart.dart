import 'package:flutter/material.dart';
import 'package:pet_app/Productmodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class cart extends StatefulWidget {
  final Product value;
  cart({Key key, this.value}) : super(key: key);
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _handlePaymentSucess,
    );
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_1mWrMUyxPQXwRu',
      'amount': int.parse(widget.value.price) * 100,
      'name': 'Pet App',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSucess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'SUCESS: ' + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'ERROR: ' + response.code.toString() + '.' + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'External wallet: ' + response.walletName);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          margin: EdgeInsets.all(25),
          color: Colors.orange,
          child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(1.5),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.orange[300],
                      child: ClipOval(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset(
                              'assets/images/${widget.value.name}.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text('${widget.value.name}',
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text('${widget.value.category}',
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text('${widget.value.price}',
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  InkWell(
                    child: Container(
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text("Proceed to Checkout",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                    onTap: () {
                      openCheckout();
                    },
                  ),
                ],
              ))),
    );
  }
}
