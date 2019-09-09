// import 'package:flutter/material.dart';
// import 'package:saveat/utils/theme.dart' as AppTheme;

//     double _lowerValue = 20.0;
//   double _upperValue = 80.0;

// void filterBottomSheet(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return ListView(
//             children: <Widget>[
//               Container(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 16, right: 16, bottom: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "Sort & Filter",
//                               style: TextStyle(fontSize: 15),
//                             ),
//                             Icon(
//                               Icons.close,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                             color: AppTheme.Colors.grayOne,
//                             border: Border(
//                                 top:
//                                     BorderSide(color: Colors.black, width: 0.4),
//                                 bottom: BorderSide(
//                                     color: Colors.black, width: 0.4))),
//                         child: Text(
//                           "Sort By",
//                           style: TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: AppTheme.Colors.white,
//                               border: Border(
//                                   bottom: BorderSide(
//                                       color: Colors.black, width: 0.4))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.alarm_on,
//                                     color: AppTheme.Colors.primaryColor,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5),
//                                     child: Text(
//                                       "Pickup Time",
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 "Any",
//                                 style: TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           )),
//                       Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: AppTheme.Colors.white,
//                               border: Border(
//                                   bottom: BorderSide(
//                                       color: Colors.black, width: 0.4))),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: AppTheme.Colors.primaryColor,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "BestBuy Date",
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: AppTheme.Colors.white,
//                               border: Border(
//                                   bottom: BorderSide(
//                                       color: Colors.black, width: 0.4))),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: AppTheme.Colors.primaryColor,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Low to High Prices",
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: AppTheme.Colors.white,
//                               border: Border(
//                                   bottom: BorderSide(
//                                       color: Colors.black, width: 0.4))),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: AppTheme.Colors.primaryColor,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "High to Low Prices",
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                             color: AppTheme.Colors.grayOne,
//                             border: Border(
//                                 top:
//                                     BorderSide(color: Colors.black, width: 0.4),
//                                 bottom: BorderSide(
//                                     color: Colors.black, width: 0.4))),
//                         child: Text(
//                           "Filter By",
//                           style: TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 16),
//                         child: Text(
//                           "Distance",
//                           style: TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "0 USD",
//                               style: TextStyle(
//                                   fontSize: 8, fontWeight: FontWeight.w600),
//                             ),
//                             Text(
//                               "100 USD",
//                               style: TextStyle(
//                                   fontSize: 8, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: SliderTheme(
//                           data: SliderTheme.of(context).copyWith(
//                             overlayColor: AppTheme.Colors.primaryColor,
//                             activeTickMarkColor: AppTheme.Colors.white,
//                             activeTrackColor: AppTheme.Colors.primaryColor,
//                             inactiveTrackColor: AppTheme.Colors.grayTwo,
//                             thumbColor: AppTheme.Colors.primaryColor,
//                             valueIndicatorColor: AppTheme.Colors.primaryColor,
//                           ),
//                           child: frs.RangeSlider(
//                             min: 0.0,
//                             max: 100.0,
//                             lowerValue: _lowerValue,
//                             upperValue: _upperValue,
//                             divisions: 5,
//                             showValueIndicator: true,
//                             valueIndicatorMaxDecimals: 1,
//                             onChanged:
//                                 (double newLowerValue, double newUpperValue) {
//                               setState(() {
//                                 _lowerValue = newLowerValue;
//                                 _upperValue = newUpperValue;
//                               });
//                             },
//                             // onChangeStart:
//                             //     (double startLowerValue, double startUpperValue) {
//                             //   print(
//                             //       'Started with values: $startLowerValue and $startUpperValue');
//                             // },
//                             // onChangeEnd: (double newLowerValue, double newUpperValue) {
//                             //   print(
//                             //       'Ended with values: $newLowerValue and $newUpperValue');
//                             // },
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Container(
//                         child: Row(
//                           children: <Widget>[
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 width: MediaQuery.of(context).size.width / 2,
//                                 child: Container(
//                                   padding: EdgeInsets.all(14),
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: AppTheme.Colors.primaryColor),
//                                       borderRadius: BorderRadius.circular(25)),
//                                   child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Apply",
//                                         style: TextStyle(
//                                             color:
//                                                 AppTheme.Colors.primaryColor),
//                                       )),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 width: MediaQuery.of(context).size.width / 2,
//                                 child: Container(
//                                   padding: EdgeInsets.all(14),
//                                   decoration: BoxDecoration(
//                                       color: AppTheme.Colors.primaryColor,
//                                       borderRadius: BorderRadius.circular(25)),
//                                   child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Reset",
//                                         style: TextStyle(color: Colors.white),
//                                       )),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//             ],
//           );
//         });
//   }
// }
