import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/vendorListView.dart';
import 'package:scoped_model/scoped_model.dart';

class VendorProduct extends StatelessWidget {
  final String vendorId;
  VendorProduct(this.vendorId, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel proModel = MyScopedModel();
    proModel.fetchProductByVendorID(vendorId);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0xff, 32, 168, 74),
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0xff, 32, 168, 74),
          leading: InkWell(
            onTap: Navigator.of(context).pop,
            child: Icon(Icons.chevron_left, size: 40),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Vendor Name",
                style: TextStyle(
                  letterSpacing: -0.41,
                  fontSize: 17.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '(${proModel.products.length.toString()}   items)',
                  style: TextStyle(
                    fontSize: 8.0,
                    letterSpacing: -0.35,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: ScopedModel<MyScopedModel>(
          model: proModel,
          child: ProductByVendorIDScoped(),
        ));
  }
}

class ProductByVendorIDScoped extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyScopedModel>(
      builder: (context, Widget child, MyScopedModel model) {
        Widget content = Text('No Products');
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.products.length > 0) {
          content =
              // VendorListView().vendorListView(MediaQuery.of(context).size.width, model);
              VendorListView().vendorListView(
                  MediaQuery.of(context).size.width, context, model);
        }
        return content;
      },
    );
  }
}
