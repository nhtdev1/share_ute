import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';

class PremiumActiveWidget extends StatefulWidget {
  PremiumActiveWidget({Key key}) : super(key: key);
  @override
  _PremiumActiveWidgetState createState() => _PremiumActiveWidgetState();
}

class _PremiumActiveWidgetState extends State<PremiumActiveWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                upperCurvedContainer(context),
                circularButtonWidget(context, screenWidth),
              ],
            ),
            SizedBox(height: screenWidth * 0.40),
            _buildExpiredDate(),
            SizedBox(height: 20),
            // We need to pass parameters to this widget
            _buildFeatureIcons(
              'Premium giúp mọi thứ trở nên dễ dàng',
              Colors.transparent,
              crownPngUrl,
              'Kenya',
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget upperCurvedContainer(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        height: 320,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: curveGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _topRow(),
            Text('uteshare.com', style: domainStyle),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Image.network(crownPngUrl, height: 36),
              SizedBox(width: 12),
              Text(
                'Premium',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget circularButtonWidget(BuildContext context, width) {
    return Positioned(
      bottom: -width * 0.36,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: width * 0.51,
            width: width * 0.51,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: curveGradient,
              // color: Colors.red,
            ),
            child: Center(
              child: Container(
                height: width * 0.4,
                width: width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                ),
                child: Center(
                  child: Container(
                    height: width * 0.3,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: greenGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0XFF00D58D).withOpacity(.2),
                            spreadRadius: 15,
                            blurRadius: 15,
                          ),
                        ]),
                    child: Center(
                      child: Icon(Icons.share, color: Colors.white, size: 50),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //top left widget
          Positioned(
            left: 8,
            top: 30,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 60,
              width: 60,
              decoration:
                  BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(crownPngUrl),
                  radius: 40,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiredDate() {
    return BlocBuilder<UpgradeCubit, UpgradeState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text:
                TextSpan(text: 'Ngày', style: expiredDateLabelStyle, children: [
              TextSpan(text: ' hết hạn\n', style: expiredDateTitleStyle),
              TextSpan(text: '${state.user.premium}', style: expiredDateStyle),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildFeatureIcons(title, cardbackgroundColor, flag, country) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title, style: featureIconsStyle),
          SizedBox(height: 14.0),
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardbackgroundColor,
              border: Border.all(
                color: Color(0XFF9BB1BD),
                style: BorderStyle.solid,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Icon(Icons.cloud_upload_outlined),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Icon(Icons.cloud_download_outlined),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Icon(Icons.storage),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Icon(Icons.folder),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I am using bezier curves to compe up with perfect curve for clipping

    Path path = Path()
      ..moveTo(0, size.height)
      ..cubicTo(size.width * 1 / 4, size.height * 14 / 15, size.width * 0.175,
          size.height * 2 / 3, size.width * 0.5, size.height * 2 / 3)
      ..cubicTo(size.width * 0.825, size.height * 2 / 3, size.width * 0.725,
          size.height * 14 / 15, size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

const crownPngUrl = 'https://image.flaticon.com/icons/png/512/277/277693.png';

const backgroundColor = Color(0XFF021B3A);

const curveGradient = RadialGradient(
  colors: <Color>[
    Color(0XFF313F70),
    Color(0XFF203063),
  ],
  focalRadius: 16,
);

const domainStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: 26,
);

const greenGradient = LinearGradient(
  colors: <Color>[
    Color(0XFF00D58D),
    Color(0XFF00C2A0),
  ],
);

const expiredDateLabelStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w600,
  height: 1.6,
  color: Colors.white,
);
const expiredDateTitleStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w600,
  color: Colors.greenAccent,
);
const expiredDateStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
const featureIconsStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Color(0XFF9BB1BD),
);
