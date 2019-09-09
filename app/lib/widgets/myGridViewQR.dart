import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myTextView.dart';

class MyGridViewQR {
  Widget myGridViewQR(context, MyScopedModel model, userID) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: model.cart.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              _showDialogue(context, model.cart[index].vendorID, userID,
                  model.cart[index].vendorName);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 8.0),
              margin: EdgeInsets.all(4.0),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(82, 80, 80, 0.5),
                      blurRadius: 5.0,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  QrImage(
                    data: model.cart[index].vendorID + userID,
                    size: 120,
                    gapless: false,
                  ),
                  MyTextView().myTextViewStatic(
                      2.0,
                      model.cart[index].vendorName,
                      Colors.black,
                      14.0,
                      FontWeight.bold)
                ],
              ),
            ));
      },
    );
  }

  void _showDialogue(context, vendorID, userID, text) {
    showDialog(
        context: context,
        builder: (_) => Material(
              type: MaterialType.transparency,
              child: Container(
                color: Colors.green.withAlpha(60),
                child: Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white.withAlpha(210),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      QrImage(
                        data: "{ vendorID : ${vendorID} , userID : ${userID}}",
                        size: 160,
                        gapless: false,
                      ),
                      MyTextView().myTextViewDynamic(0.0, 12.0, 0.0, 12.0, text,
                          Colors.black, 14.0, FontWeight.bold),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      )
                    ],
                  ),
                )),
              ),
            ));
  }
}
