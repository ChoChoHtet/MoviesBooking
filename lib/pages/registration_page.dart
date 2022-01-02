import 'package:flutter/material.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/welcome_view.dart';

class RegistrationPage extends StatelessWidget {
  final List<String> tabList = ["Login", "Sign in"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM),
      child: ListView(
        children: [
          SizedBox(
            height: MARGIN_XXLARGE,
          ),
          WelcomeView(
            REGISTRATION_WELCOME_BACK_TEXT,
            isStartAlign: true,
            welcomeColor: Colors.black,
            descriptionColor: Colors.black26,
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          RegistrationTabView(tabList),
        ],
      ),
    ));
  }
}

class RegistrationTabView extends StatefulWidget {
  final List<String> tabList;

  const RegistrationTabView(this.tabList);

  @override
  _RegistrationTabViewState createState() => _RegistrationTabViewState();
}

class _RegistrationTabViewState extends State<RegistrationTabView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // DefaultTabController(
        //   length: widget.tabList.length,
        //   child: TabBar(
        //     onTap: (index) {
        //       tabIndex = index;
        //     },
        //     labelColor: WELCOME_SCREEN_BACKGROUND_COLOR,
        //     unselectedLabelColor: Colors.black87,
        //     indicatorColor: WELCOME_SCREEN_BACKGROUND_COLOR,
        //     indicatorWeight: 4,
        //     tabs: widget.tabList
        //         .map(
        //           (desc) => Tab(
        //             child: Text(
        //               desc,
        //               style: TextStyle(
        //                 fontSize: TEXT_REGULAR,
        //               ),
        //             ),
        //           ),
        //         )
        //         .toList(),
        //   ),
        // ),
        // CustomScrollView(
        //   slivers: [
        //     SliverList(
        //       delegate: SliverChildListDelegate(
        //         <Widget>[],
        //       ),
        //     )
        //   ],
        // ),
        Container(
          child: TabBar(
            controller: _tabController,
            labelColor: WELCOME_SCREEN_BACKGROUND_COLOR,
            unselectedLabelColor: Colors.black87,
            indicatorColor: WELCOME_SCREEN_BACKGROUND_COLOR,
            indicatorWeight: 4,
            tabs: widget.tabList
                .map(
                  (desc) => Tab(
                    child: Text(
                      desc,
                      style: TextStyle(
                        fontSize: TEXT_REGULAR,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.3,
          padding: EdgeInsets.symmetric(vertical: MARGIN_LARGE_2),
          child: TabBarView(
            controller: _tabController,
            children: [
              LoginView(),
              SignInView(),
            ],
          ),
        )
      ],
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      padding: EdgeInsets.symmetric(vertical: MARGIN_XLARGE),
      children: [
        InputFieldView(
         REGISTRATION_EMAIL,
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          REGISTRATION_PASSWORD,
          obscureText: true,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Align(
          alignment: Alignment.centerRight,
          child: ForgotPasswordView(),
        ),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        SocialMediaView(),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        ElevatedButtonView(
          REGISTRATION_CONFIRM_BUTTON_TEXT,
          () => _navigateToMoviesDetailScreen(context),
        )
      ],
    );
  }

  void _navigateToMoviesDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(),
      ),
    );
    print("confirm clicked");
  }
}

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: MARGIN_XLARGE),
      children: [
        InputFieldView(
          REGISTRATION_EMAIL,
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
         REGISTRATION_PASSWORD,
          obscureText: true,
        ),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(REGISTRATION_NAME),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(
          REGISTRATION_PHONE_NUMBER,
          inputType: TextInputType.phone,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Align(
          alignment: Alignment.centerRight,
          child: ForgotPasswordView(),
        ),
        SizedBox(height: MARGIN_XLARGE),
        SocialMediaView(),
        SizedBox(height: MARGIN_XLARGE),
        ElevatedButtonView(REGISTRATION_CONFIRM_BUTTON_TEXT,
            () => _navigateToHomeScreen(context)),
      ],
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}

class SocialMediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlineButtonView(REGISTRATION_FACEBOOK_BUTTON_TEXT, "assets/ic_facebook.png"),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        OutlineButtonView(REGISTRATION_GOOGLE_BUTTON_TEXT, "assets/ic_google.png"),
      ],
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NormalTextView( REGISTRATION_FORGOT_PASSWORD,textColor: Colors.black26,);
  }
}

class OutlineButtonView extends StatelessWidget {
  final String buttonText;
  final String buttonImageName;

  const OutlineButtonView(this.buttonText, this.buttonImageName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: MARGIN_SMALL_2,
        horizontal: MARGIN_MEDIUM,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: const Color(0xffe0e1e3), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MARGIN_LARGE,
          ),
          Image.asset(
            buttonImageName,
            width: SOCIAL_MEDIA_ICON_SIZE,
            height: SOCIAL_MEDIA_ICON_SIZE,
          ),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
         NormalTextView(buttonText,textColor: Colors.black26,),
        ],
      ),
    );
  }
}
