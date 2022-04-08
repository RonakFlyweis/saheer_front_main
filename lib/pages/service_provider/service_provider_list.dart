import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';
import '../../constant/constant.dart';
import '../screens.dart';

class ServiceProviderList extends StatefulWidget {
  //final providerList;

  const ServiceProviderList({Key key}) : super(key: key);
  @override
  _ServiceProviderListState createState() => _ServiceProviderListState();
}

class _ServiceProviderListState extends State<ServiceProviderList> {
  String selectedSortBy = 'Job Completed';
  // final providerList = [
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
  //   {
  //     'name': 'Linnea Hayden',
  //     'image': 'assets/provider/provider_4.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '297',
  //     'rate': '17',
  //     'rating': '4.9',
  //     'heroTag': 'provider_4'
  //   },
  //   {
  //     'name': 'Amara Smith',
  //     'image': 'assets/provider/provider_5.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '199',
  //     'rate': '16',
  //     'rating': '4.5',
  //     'heroTag': 'provider_5'
  //   },
  //   {
  //     'name': 'John Smith',
  //     'image': 'assets/provider/provider_6.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '150',
  //     'rate': '13',
  //     'rating': '4.2',
  //     'heroTag': 'provider_6'
  //   },
  //   {
  //     'name': 'Faina Maxwell',
  //     'image': 'assets/provider/provider_7.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '259',
  //     'rate': '19',
  //     'rating': '5.0',
  //     'heroTag': 'provider_7'
  //   },
  //   {
  //     'name': 'Simone Root',
  //     'image': 'assets/provider/provider_8.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '139',
  //     'rate': '17',
  //     'rating': '4.8',
  //     'heroTag': 'provider_8'
  //   },
  //   {
  //     'name': 'Ellison Perry',
  //     'image': 'assets/provider/provider_9.jpg',
  //     'service': 'Cleaner',
  //     'jobs': '297',
  //     'rate': '23',
  //     'rating': '5.0',
  //     'heroTag': 'provider_9'
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    ProgressDialog progressDialog =
        ProgressDialog(context: (context), barrierDismissible: false);
    ApiProvider api = ApiProvider();
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.0,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          centerTitle: true,
          title: Text(
            'Full Home Cleaning',
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
            future: api.getMethod('api/getservice'),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data["getservice"].length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = snapshot.data["getservice"][index];
                    return Padding(
                      padding: (index != snapshot.data["getservice"].length - 1)
                          ? const EdgeInsets.fromLTRB(fixPadding * 2.0,
                              fixPadding * 2.0, fixPadding * 2.0, 0.0)
                          : EdgeInsets.all(fixPadding * 2.0),
                      child: InkWell(
                        onTap: () async {
                          ApiProvider api = ApiProvider();
                          progressDialog.showMaterial(
                              layout: MaterialProgressDialogLayout
                                  .overlayCircularProgressIndicator);
                          dynamic body =
                              await api.getMethod('api/getallreview');
                          progressDialog.dismiss();
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 600),
                              type: PageTransitionType.fade,
                              child: ServiceProvider(
                                heroTag: 'provider_1',
                                image: 'assets/provider/provider_1.jpg',
                                servant: item,
                                reviewList: body['getreview'],
                              ),
                            ),
                          );
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["name"],
                                            style: black14RegularTextStyle,
                                          ),
                                          height5Space,
                                          Text(
                                            item["includeservices"][0]["title"],
                                            style: grey12BoldTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width - fixPadding * 7.0 - 100.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                style: grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                item["jobs"],
                                                style: black14BoldTextStyle,
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
                                                style: grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                '\$${item["rate"]}/hr',
                                                style: black14BoldTextStyle,
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
                                                style: grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star_rate,
                                                    size: 20.0,
                                                    color: orangeColor,
                                                  ),
                                                  Text(
                                                    item["rating"],
                                                    style: black14BoldTextStyle,
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
            }));
  }
}
