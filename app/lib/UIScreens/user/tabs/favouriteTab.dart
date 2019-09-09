import 'package:flutter/material.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myClipper.dart';
import 'package:saveat/widgets/myGridView.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
bool checkValue = false;
String name, email, type, userID;

class FavouriteTab extends StatefulWidget {
  @override
  _FavouriteTabState createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  final MyScopedModel myScopedModel = MyScopedModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
    myScopedModel.fetchFavourite(userID);
    print(userID);
  }

  _getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          setState(() {
            email = sharedPreferences.getString("Email");
            name = sharedPreferences.getString("Name");
            type = sharedPreferences.getString("Type");
            userID = sharedPreferences.getString("id");
          });
        } else {
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: myScopedModel,
      child: Scaffold(
          body: ScopedModelDescendant<MyScopedModel>(
              builder: (BuildContext context, _, MyScopedModel myScopedModel) =>
                  ListView(
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 14.0, right: 14.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.15752-9/69429050_2353534051391060_3495877802966646784_n.jpg?_nc_cat=111&_nc_oc=AQkzqjyEFvnDhE1mQxDZTP2zfTWL0RHDRR2o23uwACmS1bP3377vZPyQqrVHmU3dlBU&_nc_ht=scontent.fktm8-1.fna&oh=70448f5d5e65eba1963d73638a150a2d&oe=5DE1429D'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    Icon(
                                      Icons.scanner,
                                      size: 40.0,
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45.0,
                                  margin: EdgeInsets.only(top: 14.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
                                    child: TextField(
                                        decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color.fromRGBO(142, 142, 147, 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(142, 142, 147, 1)),
                                      hintText: "What you are looking for?",
                                      fillColor: Colors.white,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 37.0),
                                  child: Text('Favourite',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          letterSpacing: 0.16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(child: FavouriteTabScoped(myScopedModel))
                    ],
                  ))),
    );
  }
}

// class FavouriteTab extends StatelessWidget {
//   final String userID;
//   FavouriteTab(this.userID, {Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final MyScopedModel myScopedModel = MyScopedModel();
//     myScopedModel.fetchFavourite(userID);
//     print(userID);
//     return Scaffold(
//         body: ListView(
//       children: <Widget>[
//         ClipPath(
//           clipper: MyClipper(),
//           child: Container(
//             height: 250.0,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Color.fromARGB(0xff, 32, 168, 74),
//             ),
//             child: Container(
//               margin: EdgeInsets.only(left: 14.0, right: 14.0),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                         height: 50.0,
//                         width: 50.0,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                                 'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.15752-9/69429050_2353534051391060_3495877802966646784_n.jpg?_nc_cat=111&_nc_oc=AQkzqjyEFvnDhE1mQxDZTP2zfTWL0RHDRR2o23uwACmS1bP3377vZPyQqrVHmU3dlBU&_nc_ht=scontent.fktm8-1.fna&oh=70448f5d5e65eba1963d73638a150a2d&oe=5DE1429D'),
//                           ),
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                       ),
//                       Icon(
//                         Icons.scanner,
//                         size: 40.0,
//                       )
//                     ],
//                   ),
//                   Container(
//                     height: 45.0,
//                     margin: EdgeInsets.only(top: 14.0),
//                     child: Padding(
//                       padding: const EdgeInsets.only(),
//                       child: TextField(
//                           decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(vertical: 2),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Color.fromRGBO(142, 142, 147, 1),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(2),
//                           borderSide: BorderSide(
//                             width: 0,
//                             style: BorderStyle.none,
//                           ),
//                         ),
//                         filled: true,
//                         hintStyle:
//                             TextStyle(color: Color.fromRGBO(142, 142, 147, 1)),
//                         hintText: "What you are looking for?",
//                         fillColor: Colors.white,
//                       )),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 37.0),
//                     child: Text('Favourite',
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             letterSpacing: 0.16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         ScopedModel<MyScopedModel>(
//           model: myScopedModel,
//           child: Center(child: FavouriteTabScoped()),
//         )
//       ],
//     ));
//   }
// }

class FavouriteTabScoped extends StatelessWidget {
  final MyScopedModel myScopedModel;
  FavouriteTabScoped(this.myScopedModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Text('No Favourite data');
    if (myScopedModel.isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else if (!myScopedModel.isLoading &&
        myScopedModel.favourites.length > 0) {
      content = _buildListView(context, myScopedModel);
    }
    return content;
  }

  Widget _buildListView(context, MyScopedModel model) {
    return Container(child: MyGridView().myGridView(context, model));
  }
}
