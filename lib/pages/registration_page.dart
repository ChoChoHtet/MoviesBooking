import 'package:flutter/material.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';
import 'package:movies_booking/widgets/welcome_view.dart';

class RegistrationPage extends StatelessWidget {
  final List<String> tabList = ["Login", "Sign in"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MARGIN_MEDIUM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
              ),
              WelcomeView(
                "Welcome back, login to continue",
                isStartAlign: true,
                welcomeColor: Colors.black,
                descriptionColor: Colors.blueGrey,
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              RegistrationTabView(tabList),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationTabView extends StatefulWidget {
  final List<String> tabList;

  const RegistrationTabView(this.tabList);

  @override
  _RegistrationTabViewState createState() => _RegistrationTabViewState();
}

class _RegistrationTabViewState extends State<RegistrationTabView> {
  @override
  Widget build(BuildContext context) {
    int tabIndex = 0;
    return Column(
      children: [
        DefaultTabController(
          length: widget.tabList.length,
          child: TabBar(
            onTap: (index) {
              tabIndex = index;
            },
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
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        tabIndex == 0 ? LoginView() : SignInView()
      ],
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputFieldView(
          "Email",
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          "Password",
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
          "Confirm",
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

class SocialMediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlineButtonView("Sign in with Facebook", "assets/ic_facebook.png"),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        OutlineButtonView("Sign in with Google", "assets/ic_google.png"),
      ],
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Forgot Password ?",
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputFieldView(
          "Email",
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          "Password",
          obscureText: true,
        ),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView("Name"),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(
          "Phone Number",
          inputType: TextInputType.phone,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Align(
          alignment: Alignment.centerRight,
          child: ForgotPasswordView(),
        ),
        SizedBox(height: MARGIN_XLARGE),
        SocialMediaView(),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        ElevatedButtonView("Confirm",() => _navigateToMoviesDetailScreen(context))
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
          Text(
            buttonText,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: TEXT_REGULAR,
            ),
          ),
        ],
      ),
    );
  }
}
