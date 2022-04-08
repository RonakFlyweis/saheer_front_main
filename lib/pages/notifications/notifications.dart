import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';
import '../../constant/constant.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // final notificationList = [
  //   {
  //     'title': 'Booking Confirm',
  //     'description': 'Congratulation... Your booking has been confirmed'
  //   },
  //   {
  //     'title': 'Invite your friend and earn upto \$20',
  //     'description':
  //         'Share your referral code with your friends and earn upto \$20.'
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    ApiProvider api = ApiProvider();
    ProgressDialog progressDialog =
        ProgressDialog(context: (context), barrierDismissible: false);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: whiteColor,
        title: Text(
          'Notifications',
          style: black18BoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
          future: api.getMethodAuthorized('api/getNotification'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final notificationList = snapshot.data["getNotification"];
              return snapshot.data["getNotification"].length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off,
                            size: 46.0,
                            color: greyColor,
                          ),
                          heightSpace,
                          Text(
                            'No new notifications',
                            style: grey16BoldTextStyle,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (context, index) {
                        final data = notificationList[index];
                        return Dismissible(
                          key: Key('$data'),
                          onDismissed: (direction) async {
                            progressDialog.showMaterial(
                                layout: MaterialProgressDialogLayout
                                    .overlayCircularProgressIndicator);
                            await api.deleteMethod('api/deletenotification');
                            progressDialog.dismiss();
                            setState(() {
                              // notificationList.removeAt(index);
                            });

// Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Notification deleted")));
                          },
// Show a red background as the item is swiped away.
                          background: Container(
                            margin: (index == notificationList.length - 1)
                                ? EdgeInsets.symmetric(
                                    vertical: fixPadding * 2.0)
                                : EdgeInsets.only(top: fixPadding * 2.0),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: (index == notificationList.length - 1)
                                ? EdgeInsets.all(fixPadding * 2.0)
                                : EdgeInsets.fromLTRB(fixPadding * 2.0,
                                    fixPadding * 2.0, fixPadding * 2.0, 0.0),
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                    color: blackColor.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      size: 24.0,
                                      color: whiteColor,
                                    ),
                                  ),
                                  widthSpace,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Booking Notification",
                                          style: black14BoldTextStyle,
                                        ),
                                        height5Space,
                                        Text(
                                          data['bookingNotification'],
                                          style: black14MediumTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
          }),
    );
  }
}
