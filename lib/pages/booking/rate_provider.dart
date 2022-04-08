import 'package:flutter/material.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import '../../api_provider/url.dart';
import '../../constant/constant.dart';

class RateProvider extends StatefulWidget {
  @override
  _RateProviderState createState() => _RateProviderState();
}

class _RateProviderState extends State<RateProvider> {
  int rate = 0;
  TextEditingController reviewText = TextEditingController();
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
          'Rate Provider',
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
            ApiProvider api = ApiProvider();
            final body = {"rating": rate, "description": reviewText.text};
            progressDialog.showMaterial(
                layout: MaterialProgressDialogLayout
                    .overlayCircularProgressIndicator);
            await api.postMethod(body, 'api/addreview');
            progressDialog.dismiss();

            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: 50.0,
            color: primaryColor,
            alignment: Alignment.center,
            child: Text(
              'Submit',
              style: white18BoldTextStyle,
            ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          providerDetailCard(),
          height20Space,
          ratingBar(),
          height20Space,
          writeReview(reviewText),
          height20Space,
        ],
      ),
    );
  }

  providerDetailCard() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
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
              child: Image.asset(
                'assets/provider/provider_7.jpg',
                width: 84.0,
                height: 84.0,
                fit: BoxFit.cover,
              ),
            ),
            widthSpace,
            Container(
              height: 84.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amara Smith',
                    style: black16BoldTextStyle,
                  ),
                  Text(
                    'Cleaner',
                    style: grey14MediumTextStyle,
                  ),
                  Text(
                    '\$16/hr',
                    style: primaryColor16MediumTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ratingBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                rate = 1;
              });
            },
            child: Icon(
              (rate == 1 || rate == 2 || rate == 3 || rate == 4 || rate == 5)
                  ? Icons.star
                  : Icons.star_border,
              color: orangeColor,
              size: 40.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rate = 2;
              });
            },
            child: Icon(
              (rate == 2 || rate == 3 || rate == 4 || rate == 5)
                  ? Icons.star
                  : Icons.star_border,
              color: orangeColor,
              size: 40.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rate = 3;
              });
            },
            child: Icon(
              (rate == 3 || rate == 4 || rate == 5)
                  ? Icons.star
                  : Icons.star_border,
              color: orangeColor,
              size: 40.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rate = 4;
              });
            },
            child: Icon(
              (rate == 4 || rate == 5) ? Icons.star : Icons.star_border,
              color: orangeColor,
              size: 40.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rate = 5;
              });
            },
            child: Icon(
              (rate == 5) ? Icons.star : Icons.star_border,
              color: orangeColor,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }

  writeReview(TextEditingController reviewText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          controller: reviewText,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          style: black14MediumTextStyle,
          decoration: InputDecoration(
            hintText: 'Write your review here',
            hintStyle: grey14MediumTextStyle,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: primaryColor, width: 1.0),
            ),
            fillColor: whiteColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}
