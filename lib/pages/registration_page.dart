import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
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
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl() ;

  UserVO? user;
  @override
  void initState() {

    super.initState();
  }
  void _registerUser(String name,String email,String phone,String password){
    print("clicked register user-> $name,$email,$phone,$password");
    _movieBookingModel.emailRegister(name, email, phone, password).then((userResponse) {
      this.user = userResponse ;
      // debugPrint("Register -> Successful");
      // Fluttertoast.showToast(
      //     msg: "Register Successful!",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      _navigateToHomeScreen(context);
    }).catchError((error){
      debugPrint("Register Error -> $error");
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
              LoginView(),
              SignInView(onClickConfirm: (name, email, phone, password) {
                _registerUser(name, email, phone, password);
              }),
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
          textValue: (value){
           // this.phone = phone ;
          },
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
          REGISTRATION_PASSWORD,
          obscureText: true,
            textValue: (value){
              // this.phone = phone ;
            }
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
        builder: (context) => HomePage(),
      ),
    );
    print("confirm clicked");
  }
}

class SignInView extends StatelessWidget {
  final Function(String name, String email,String phone, String password) onClickConfirm;
   SignInView({required this.onClickConfirm});
  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: MARGIN_XLARGE),
      children: [
        InputFieldView(
          REGISTRATION_EMAIL,
          inputType: TextInputType.emailAddress,
          textValue: (email){
            this.email = email ;
          },
        ),
        SizedBox(height: MARGIN_LARGE),
        InputFieldView(
         REGISTRATION_PASSWORD,
          obscureText: true,
          textValue: (password){
            this.password = password ;
          },
        ),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(REGISTRATION_NAME,textValue:(userName){
          this.name = userName ;
        },),
        SizedBox(height: MARGIN_XLARGE),
        InputFieldView(
          REGISTRATION_PHONE_NUMBER,
          inputType: TextInputType.phone,
          textValue: (phone){
            this.phone = phone ;
          },
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
            () => onClickConfirm(this.name,this.email,this.phone,this.password)),
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
