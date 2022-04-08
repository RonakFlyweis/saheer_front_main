import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';
import '../../constant/constant.dart';
import '../screens.dart';
import '../../widget/column_builder.dart';

class SelectAddress extends StatefulWidget {
  final service;
  final time;
  final date;
  const SelectAddress({Key key, this.service, this.time, this.date})
      : super(key: key);
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String selectedAddress = '120, Yogi Villa, Opera Street, New York.';

  final addressList = [
    {'address': '120, Yogi Villa, Opera Street, New York.', 'type': 'home'},
    {'address': 'G-12, Abc Mart, Opera Street, New York.', 'type': 'work'}
  ];

  TextEditingController houseNo = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.service + " " + widget.date + " " + widget.time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog =
        ProgressDialog(context: (context), barrierDismissible: false);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: whiteColor,
        title: Text(
          'Select address',
          style: appBarTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 1.0,
        child: InkWell(
          onTap: () async {
            progressDialog.showMaterial(
                layout: MaterialProgressDialogLayout
                    .overlayCircularProgressIndicator);
            ApiProvider api = ApiProvider();
            var addressBody = {
              "houseno": houseNo.text.toString(),
              "landmark": landmark.text.toString(),
              "city": city.text.toString(),
              "State": state.text.toString(),
            };
            int addressCode =
                await api.postMethod(addressBody, 'api/addaddress');
            progressDialog.dismiss();
            progressDialog.showMaterial(
                layout: MaterialProgressDialogLayout
                    .overlayCircularProgressIndicator);
            dynamic address = await api.getMethodAuthorized('api/getaddress');
            progressDialog.dismiss();
            var body = {
              "service": widget.service,
              "time": widget.time,
              "address": address["getaddress"][0]["_id"],
              "date": widget.date
            };
            progressDialog.showMaterial(
                layout: MaterialProgressDialogLayout
                    .overlayCircularProgressIndicator);
            int code = await api.postMethod(body, 'api/Booking');
            await api.addNotification();
            progressDialog.dismiss();
            if (code == 200) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: BookingSuccess(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Booking Failed")));
            }
          },
          child: Container(
            width: double.infinity,
            height: 50.0,
            color: primaryColor,
            alignment: Alignment.center,
            child: Text(
              'Continue',
              style: white18BoldTextStyle,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          heightSpace,
          heightSpace,
          // Name textfield start
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: TextField(
                controller: houseNo,
                style: black16MediumTextStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "House Number",
                  hintStyle: grey16MediumTextStyle,
                  fillColor: scaffoldBgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          // Name textfield end
          heightSpace,
          heightSpace,
          // Name textfield start
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: TextField(
                controller: landmark,
                style: black16MediumTextStyle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Landmark",
                  hintStyle: grey16MediumTextStyle,
                  fillColor: scaffoldBgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          heightSpace,
          heightSpace,
          // Name textfield start
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: TextField(
                controller: city,
                style: black16MediumTextStyle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "City",
                  hintStyle: grey16MediumTextStyle,
                  fillColor: scaffoldBgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          heightSpace,
          heightSpace,
          // Name textfield start
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: TextField(
                controller: state,
                style: black16MediumTextStyle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "State",
                  hintStyle: grey16MediumTextStyle,
                  fillColor: scaffoldBgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          // ColumnBuilder(
          //   itemCount: addressList.length,
          //   itemBuilder: (context, index) {
          //     final item = addressList[index];
          //     return Padding(
          //       padding: const EdgeInsets.fromLTRB(
          //           fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0),
          //       child: InkWell(
          //         onTap: () {
          //           setState(() {
          //             selectedAddress = item['address'];
          //           });
          //         },
          //         borderRadius: BorderRadius.circular(10.0),
          //         child: Container(
          //           padding: EdgeInsets.all(fixPadding),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.0),
          //             color: whiteColor,
          //             border: Border.all(
          //               width: 1.0,
          //               color: (item['address'] == selectedAddress)
          //                   ? primaryColor
          //                   : Colors.transparent,
          //             ),
          //             boxShadow: [
          //               BoxShadow(
          //                 blurRadius: 4.0,
          //                 spreadRadius: 1.0,
          //                 color: blackColor.withOpacity(0.25),
          //               ),
          //             ],
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 width: 50.0,
          //                 height: 50.0,
          //                 alignment: Alignment.center,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(25.0),
          //                   color: (item['address'] == selectedAddress)
          //                       ? primaryColor
          //                       : greyColor.withOpacity(0.5),
          //                 ),
          //                 child: Icon(
          //                     (item['type'] == 'home')
          //                         ? Icons.home
          //                         : (item['type'] == 'work')
          //                             ? Icons.work
          //                             : Icons.language,
          //                     color: (item['address'] == selectedAddress)
          //                         ? whiteColor
          //                         : primaryColor),
          //               ),
          //               widthSpace,
          //               Expanded(
          //                 child: Text(
          //                   item['address'],
          //                   style: black14MediumTextStyle,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // Padding(
          //   padding: EdgeInsets.all(fixPadding * 2.0),
          //   child: InkWell(
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //     onTap: () {},
          //     child: DottedBorder(
          //       borderType: BorderType.RRect,
          //       radius: Radius.circular(10.0),
          //       strokeWidth: 1.2,
          //       color: blackColor,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.all(Radius.circular(10)),
          //         child: Container(
          //           padding: EdgeInsets.all(fixPadding),
          //           color: whiteColor,
          //           alignment: Alignment.center,
          //           child: Text(
          //             'Add new address',
          //             style: black16BoldTextStyle,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
