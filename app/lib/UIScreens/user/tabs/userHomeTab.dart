import 'package:flutter/material.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;
import 'package:saveat/UIScreens/user/homePageStuffs/productGridView.dart';
import 'package:saveat/UIScreens/user/homePageStuffs/roundCategory.dart';
import 'package:saveat/widgets/myCarousel.dart';

class UserHomeTab extends StatefulWidget {
  final String userID;
  UserHomeTab(this.userID, {Key key}) : super(key: key);
  @override
  _UserHomeTabState createState() => _UserHomeTabState();
}

class _UserHomeTabState extends State<UserHomeTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print("dispose was called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var parentHeight = MediaQuery.of(context).size.height;
    var parentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                elevation: 0,
                snap: true,
                backgroundColor: AppTheme.Colors.primaryColor,
                brightness: Brightness.light,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.notifications),
                    color: AppTheme.Colors.white,
                    onPressed: () {},
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
                    alignment: Alignment.center,
                    child: TextField(
                        decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.Colors.gray30,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      hintText: "What are you looking for today ?",
                      fillColor: AppTheme.Colors.searchTextFieldBG,
                    )),
                  ),
                ),
              ),
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                MyCarousel().myCarousel(parentHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: Text("Categories"),
                    ),
                    InkWell(
                      onTap: () {
                        MyRoute.goToCategories(context, widget.userID);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Text("View All"),
                      ),
                    ),
                  ],
                ),
                RoundCategory(widget.userID),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Text("Trending"),
                ),
                ProductGridView(widget.userID),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }
}
