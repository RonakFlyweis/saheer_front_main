import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';
import '../../constant/constant.dart';
import '../screens.dart';

class MyBooking extends StatefulWidget {
  //final pastBookingList;

  //const MyBooking({Key key, this.pastBookingList}) : super(key: key);
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  bool dataFetched = true;

  @override
  void initState() {
    // TODO: implement initState
    //getAllData();
    super.initState();
  }

  // getAllData() async {
  //   // ProgressDialog progressDialog =
  //   //     ProgressDialog(context: (context), barrierDismissible: false);
  //   // progressDialog.showMaterial(
  //   //     layout: MaterialProgressDialogLayout.overlayCircularProgressIndicator);
  //   // Duration(seconds: 5);
  //   // progressDialog.dismiss();
  // }

  //final upcomingBookingList = comingBookingList;
  // [
  //   {
  //     'name': 'Apollonia Anderson',
  //     'date': '15 March 2021',
  //     'time': '10:00 AM',
  //     'type': 'Cleaner',
  //   },
  //   {
  //     'name': 'Linnea Hayden',
  //     'date': '21 March 2021',
  //     'time': '12:00 PM',
  //     'type': 'Cleaner',
  //   },
  //   {
  //     'name': 'John Smith',
  //     'date': '25 March 2021',
  //     'time': '04:00 PM',
  //     'type': 'Plumber',
  //   }
  // ];

  final pastBookingList = [
    {
      'name': 'Amara Smith',
      'date': '18 March 2021',
      'time': '12:00 PM',
      'type': 'Cleaner',
    },
    {
      'name': 'Shira Williamson',
      'date': '22 March 2021',
      'time': '08:00 AM',
      'type': 'Cleaner',
    },
    {
      'name': 'John Smith',
      'date': '25 March 2021',
      'time': '03:00 PM',
      'type': 'Electrician',
    },
    {
      'name': 'Faina Maxwell',
      'date': '2 April 2021',
      'time': '05:00 PM',
      'type': 'Beautician',
    }
  ];

  final cancelledBookingList = [
    {
      'name': 'Amara Smith',
      'date': '14 March 2021',
      'time': '04:00 PM',
      'type': 'Cleaner',
    },
    {
      'name': 'Ellison Perry',
      'date': '17 March 2021',
      'time': '09:00 AM',
      'type': 'Cleaner',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: whiteColor,
          title: Text(
            'Bookings',
            style: appBarTextStyle,
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
            tabs: [
              Tab(
                child: tabItem('Upcoming', 3),
                //TODO implement number
              ),
              Tab(
                child: tabItem('Past', pastBookingList.length),
              ),
              Tab(
                child: tabItem('Cancelled', cancelledBookingList.length),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            upcomingBookings(),
            pastBookings(),
            cancelledBookings(),
          ],
        ),
      ),
    );
  }

  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: black12MediumTextStyle,
        ),
        SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: white12MediumTextStyle,
          ),
        ),
      ],
    );
  }

  upcomingBookings() {
    ApiProvider api = ApiProvider();
    return FutureBuilder(
      future: api.getMethodAuthorized('api/getbooking'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          dynamic upcomingBookingList = snapshot.data["getbooking"];
          return ListView.builder(
            itemCount: upcomingBookingList.length,
            itemBuilder: (context, index) {
              final data = upcomingBookingList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: UpcomingBooking(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(width: 1.0, color: greenColor),
                              color: greenColor.withOpacity(0.20),
                            ),
                            child: Text(
                              data['date'].toString().substring(0, 10),
                              textAlign: TextAlign.center,
                              style: green14MediumTextStyle,
                            ),
                          ),
                          widthSpace,
                          Container(
                            height: 80.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['time'],
                                  style: black16BoldTextStyle,
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  data['service']['name'],
                                  style: black14MediumTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  'cleaner',
                                  style: primaryColor14RegularTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider(),
                  ],
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitRing(
                color: primaryColor,
                size: 40.0,
                lineWidth: 1.2,
              ),
              SizedBox(height: 25.0),
              Text(
                'Please Wait..',
                style: grey14MediumTextStyle,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Future<dynamic> getPastBookings() async {
    ApiProvider api = ApiProvider();
    dynamic data = await api.getMethodAuthorized('api/getbeforedate');
      for (int i = 0; i < data["getbeforedate"].length; i++) {
      dynamic id = data["getbeforedate"][i]["service"];
      dynamic servicemandata =
          await api.getMethod('api/getsingleservice/${id}');
      servicemandata = servicemandata["getservice"];
      print(servicemandata);
      data["getbeforedate"][i]["service"] = servicemandata;
      print(data);
    }
    return data;
  }

  pastBookings() {
    ApiProvider api = ApiProvider();
    return FutureBuilder(
      future: getPastBookings(),
      // future: api.getMethodAuthorized('api/getbeforedate'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          dynamic upcomingBookingList = snapshot.data["getbeforedate"];
          return ListView.builder(
            itemCount: upcomingBookingList.length,
            itemBuilder: (context, index) {
              final item = upcomingBookingList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: PastBooking(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(width: 1.0, color: greenColor),
                              color: greenColor.withOpacity(0.20),
                            ),
                            child: Text(
                              item['date'].toString().substring(0, 10),
                              textAlign: TextAlign.center,
                              style: green14MediumTextStyle,
                            ),
                          ),
                          widthSpace,
                          Container(
                            height: 80.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['time'],
                                  style: black16BoldTextStyle,
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  item["service"]["name"].toString() ?? "shadab",
                                  style: black14MediumTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  "cleaning",
                                  style: primaryColor14RegularTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider(),
                  ],
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitRing(
                color: primaryColor,
                size: 40.0,
                lineWidth: 1.2,
              ),
              SizedBox(height: 25.0),
              Text(
                'Please Wait..',
                style: grey14MediumTextStyle,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  cancelledBookings() {
    return ListView.builder(
      itemCount: cancelledBookingList.length,
      itemBuilder: (context, index) {
        final item = cancelledBookingList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: CancelledBooking(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(width: 1.0, color: redColor),
                        color: redColor.withOpacity(0.20),
                      ),
                      child: Text(
                        item['date'],
                        textAlign: TextAlign.center,
                        style: red14MediumTextStyle,
                      ),
                    ),
                    widthSpace,
                    Container(
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['time'],
                            style: black16BoldTextStyle,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['name'],
                            style: black14MediumTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['type'],
                            style: primaryColor14RegularTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: greyColor,
    );
  }
}
