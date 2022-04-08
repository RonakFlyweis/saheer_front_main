import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import '../../api_provider/url.dart';
import '../../constant/constant.dart';
import '../screens.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  // final favoriteList = [
  //   {
  //     'name': 'Apollonia Anderson',
  //     'image': 'assets/provider/provider_1.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '197',
  //     'rate': '15',
  //     'rating': '4.9',
  //     'heroTag': 'provider_1'
  //   },
  //   {
  //     'name': 'Beatriz Warner',
  //     'image': 'assets/provider/provider_2.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '205',
  //     'rate': '12',
  //     'rating': '4.6',
  //     'heroTag': 'provider_2'
  //   },
  //   {
  //     'name': 'Shira Williamson',
  //     'image': 'assets/provider/provider_3.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '158',
  //     'rate': '10',
  //     'rating': '4.5',
  //     'heroTag': 'provider_3'
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ApiProvider api = ApiProvider();
    ProgressDialog progressDialog =
        ProgressDialog(context: (context), barrierDismissible: false);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Favorite',
          style: black16BoldTextStyle,
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
          future: api.getMethod('api/getfav'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final favList = snapshot.data["getfav"];
              return snapshot.data["getfav"].length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 46.0,
                            color: greyColor,
                          ),
                          heightSpace,
                          Text(
                            'No item in favorite',
                            style: grey16BoldTextStyle,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: favList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = favList[index];
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: fixPadding * 2.0,
                                bottom: (index == favList.length - 1)
                                    ? fixPadding * 2.0
                                    : 0.0,
                              ),
                              child: IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () async {
                                  progressDialog.showMaterial(
                                      layout: MaterialProgressDialogLayout
                                          .overlayCircularProgressIndicator);
                                  await api.favPostMethod(
                                      'api/add-favroite/${data["_id"]}');
                                  progressDialog.dismiss();
                                  setState(() {
                                    // favoriteList.removeAt(index);
                                  });

                                  // Then show a snackbar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Service provider removed from favorite'),
                                  ));
                                },
                              ),
                            ),
                          ],
                          child: Padding(
                            padding: (index != favList.length - 1)
                                ? const EdgeInsets.fromLTRB(fixPadding * 2.0,
                                    fixPadding * 2.0, fixPadding * 2.0, 0.0)
                                : EdgeInsets.all(fixPadding * 2.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     duration: Duration(milliseconds: 600),
                                //     type: PageTransitionType.fade,
                                //     child: ServiceProvider(
                                //       heroTag: item['heroTag'],
                                //       image: item['image'],
                                //     ),
                                //   ),
                                // );
                              },
                              borderRadius: BorderRadius.circular(10.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Hero(
                                        tag: 'provider_1',
                                        child: Image.asset(
                                          'assets/provider/provider_1.jpg',
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                      ),
                                    ),
                                    widthSpace,
                                    Container(
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style:
                                                      black14RegularTextStyle,
                                                ),
                                                height5Space,
                                                Text(
                                                  data["includeservices"][0]
                                                      ["title"],
                                                  style: grey12BoldTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width -
                                                fixPadding * 7.0 -
                                                100.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Jobs',
                                                      style:
                                                          grey12BoldTextStyle,
                                                    ),
                                                    height5Space,
                                                    Text(
                                                      data['jobs'],
                                                      style:
                                                          black14BoldTextStyle,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Rate',
                                                      style:
                                                          grey12BoldTextStyle,
                                                    ),
                                                    height5Space,
                                                    Text(
                                                      '\$${data['rate']}/hr',
                                                      style:
                                                          black14BoldTextStyle,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Rating',
                                                      style:
                                                          grey12BoldTextStyle,
                                                    ),
                                                    height5Space,
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.star_rate,
                                                          size: 20.0,
                                                          color: orangeColor,
                                                        ),
                                                        Text(
                                                          data['rating'],
                                                          style:
                                                              black14BoldTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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

// (favoriteList.isEmpty)
