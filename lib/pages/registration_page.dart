import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/pages/home_page.dart';
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
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  UserVO? user;
  @override
  void initState() {
    super.initState();
  }

  void _registerUser(String name, String email, String phone, String password) {
    print("clicked register user-> $name,$email,$phone,$password");
    _movieBookingModel
        .emailRegister(name, email, phone, password)
        .then((userResponse) {
      this.user = userResponse;
      print(
          "Register success-> ${user?.name},${user?.email},token:${user?.token}");
      _navigateToHomeScreen(context);
    }).catchError((error) {
      debugPrint("Register Error -> $error");
    });
  }

  void _emailLogin(String email, String password) {
    print("clicked login-> $email,$password");
    _movieBookingModel.emailLogin(email, password).then((userResponse) {
      this.user = userResponse;
      print(
          "Login success -> ${user?.name},${user?.email},token:${user?.token}");
      _navigateToHomeScreen(context);
    }).catchError((error) {
      debugPrint("Login Error -> $error");
    });
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    print("confirm clicked");
  }

  void _googleLogin() {
    print("google login");
   /* GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        print("Google access token: ${authentication.accessToken}");
        _movieBookingModel
            .loginGoogle(authentication.accessToken ?? "")
            .then((response) {
          this.user = response;
          print(
              "Google Login success-> ${user?.name},${user?.email},token:${user?.token}");
          _navigateToHomeScreen(context);
        }).catchError((error) {
          debugPrint("Google Login Error: $error");
        });
      });
    });*/
  }

  void _facebookLogin() {

  }

  void _registerGoogle(
      String name, String email, String phone, String password) {
    print("google register");
   /* GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        print("Google access token: ${authentication.accessToken}");
        _movieBookingModel
            .googleRegister(
                name, email, phone, password, authentication.accessToken ?? "")
            .then((response) {
          this.user = response;
          print(
              "Google Register success-> ${user?.name},${user?.email},token:${user?.token}");
          _navigateToHomeScreen(context);
        }).catchError((error) {
          debugPrint("Google Register Error: $error");
        });
      });
    });*/
  }

  void _registerFacebook() async {
    //print("google register");
   /* final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      print("Facebook access token: ${result.accessToken}");
    }else{
      print(result.status);
      print(result.message);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
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
              LoginView(
                onClickConfirm: (email, password) =>
                    _emailLogin(email, password),
                onTapGoogle: () => _googleLogin(),
                onTapFacebook: () => _facebookLogin(),
              ),
              SignInView(
                onClickConfirm: (name, email, phone, password) =>
                    _registerUser(name, email, phone, password),
                onTapFacebook:()=> _registerFacebook(),
                onTapGoogle: (name, email, phone, password) =>
                    _registerGoogle(name, email, phone, password),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class LoginView extends StatelessWidget {
  final Function(String email, String password) onClickConfirm;
  final VoidCallback onTapGoogle;
  final VoidCallback onTapFacebook;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  LoginView(
      {required this.onClickConfirm,
      required this.onTapGoogle,
      required this.onTapFacebook});
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      padding: EdgeInsets.symmetric(vertical: MARGIN_XLARGE),
      children: [
        InputFieldView(
          REGISTRATION_EMAIL,
          inputType: TextInputType.emailAddress,
          textController: _emailController,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          REGISTRATION_PASSWORD,
          obscureText: true,
          textController: _passwordController,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Align(
          alignment: Alignment.centerRight,
          child: ForgotPasswordView(),
        ),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        SocialMediaView(
          onTapFacebook: onTapFacebook,
          onTapGoogle: onTapGoogle,
        ),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        ElevatedButtonView(
          REGISTRATION_CONFIRM_BUTTON_TEXT,
          () => onClickConfirm(
            _emailController.text,
            _passwordController.text,
          ),
        )
      ],
    );
  }
}

class SignInView extends StatelessWidget {
  final Function(String name, String email, String phone, String password)
      onClickConfirm;
  final Function(String name, String email, String phone, String password)
      onTapGoogle;
  final VoidCallback onTapFacebook;
  SignInView(
      {required this.onClickConfirm,
      required this.onTapGoogle,
      required this.onTapFacebook});
  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _nameController = TextEditingController();
  var _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: MARGIN_XLARGE),
      children: [
        InputFieldView(
          REGISTRATION_EMAIL,
          inputType: TextInputType.emailAddress,
          textController: _emailController,
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          REGISTRATION_PASSWORD,
          obscureText: true,
          textController: _passwordController,
        ),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(
          REGISTRATION_NAME,
          textController: _nameController,
        ),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(
          REGISTRATION_PHONE_NUMBER,
          inputType: TextInputType.phone,
          textController: _phoneController,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Align(
          alignment: Alignment.centerRight,
          child: ForgotPasswordView(),
        ),
        SizedBox(height: MARGIN_XLARGE),
        SocialMediaView(
          onTapFacebook: onTapFacebook,
          onTapGoogle: () => onTapGoogle(
            _nameController.text,
            _emailController.text,
            _phoneController.text,
            _passwordController.text,
          ),
        ),
        SizedBox(height: MARGIN_XLARGE),
        ElevatedButtonView(
            REGISTRATION_CONFIRM_BUTTON_TEXT,
            () => onClickConfirm(
                  _nameController.text,
                  _emailController.text,
                  _phoneController.text,
                  _passwordController.text,
                )),
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
  final VoidCallback onTapGoogle;
  final VoidCallback onTapFacebook;
  SocialMediaView({required this.onTapGoogle, required this.onTapFacebook});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTapFacebook,
          child: OutlineButtonView(
              REGISTRATION_FACEBOOK_BUTTON_TEXT, "assets/ic_facebook.png"),
        ),
        SizedBox(
          height: MARGIN_XLARGE,
        ),
        InkWell(
          onTap: onTapGoogle,
          child: OutlineButtonView(
              REGISTRATION_GOOGLE_BUTTON_TEXT, "assets/ic_google.png"),
        ),
      ],
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NormalTextView(
      REGISTRATION_FORGOT_PASSWORD,
      textColor: Colors.black26,
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
          NormalTextView(
            buttonText,
            textColor: Colors.black26,
          ),
        ],
      ),
    );
  }
}
