import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_guard/helpers/toast_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneEditingController;

  late TextEditingController _otpEditingController;

  //Flag to maintain OTP sent status. False by default. True if OTP is sent.
  late bool _isOTPSent;

  //Flag to store verificationId which will be latter use for OTP validation.
  late String _verificationId;

  //Flag to maintain OTP generation progress status. False by default.
  late bool _isOTPGenerationInProgress;

  //Flag to maintain OTP verification progress status. False by default.
  late bool _isOTPVerificationInProgress;

  //region: Overridden Functions
  @override
  void initState() {
    super.initState();
    _initScreenResources();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      ),
    );
  }

  @override
  void dispose() {
    _disposeScreenResources();
    super.dispose();
  }

//endregion`

  //region: Widgets
  Widget _buildBody() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.black,
      child: Column(
        children: [
          //Image widget
          SizedBox(
            height: 180,
            width: 180,
            child: Image.asset(
              'assets/image/womenlogin.png',
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              margin: const EdgeInsets.only(left: 16, right: 16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child:
                  _isOTPSent == false ? _buildLoginWidget() : _buildOTPWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginWidget() {
    return Column(
      children: [
        const Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 39,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.call,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneEditingController,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                        hintText: 'Mobile number',
                        border: InputBorder.none,
                        counter: SizedBox()),
                  ),
                ),
              ]),
        ),
        //Next Button
        GestureDetector(
          onTap: () {
            _onGenerateOTP();
          },
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _isOTPGenerationInProgress
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : const Text('Get OTP',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                    )),
          ),
        )
      ],
    );
  }

  Widget _buildOTPWidget() {
    return Column(
      children: [
        const Text(
          'OTP',
          style: TextStyle(
            fontSize: 39,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.phone,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    controller: _otpEditingController,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                        hintText: 'Enter OTP',
                        border: InputBorder.none,
                        counter: SizedBox()),
                  ),
                ),
              ]),
        ),
        //Next Button
        GestureDetector(
          onTap: () {
            _onVerifyOTP();
          },
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _isOTPVerificationInProgress
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : const Text('Verify OTP',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                    )),
          ),
        )
      ],
    );
  }

//endregion

  //region: Private Functions
  void _initScreenResources() {
    _phoneEditingController = TextEditingController();
    _otpEditingController = TextEditingController();

    _isOTPSent = false;
    _verificationId = '';
    _isOTPGenerationInProgress = false;
    _isOTPVerificationInProgress = false;
  }

  void _disposeScreenResources() {
    _phoneEditingController.dispose();
    _otpEditingController.dispose();
  }

  Future<void> _onGenerateOTP() async {
    if (_phoneEditingController.text.trim().length < 10) {
      ToastHelper.showLongToast('Invalid phone number length');
    } else if (_isOTPGenerationInProgress) {
      ToastHelper.showLongToast('Please wait');
    } else {
      setState(() {
        _isOTPGenerationInProgress = true;
      });
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${_phoneEditingController.text}',
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            debugPrint('verificationCompleted:');
            await FirebaseAuth.instance
                .signInWithCredential(phoneAuthCredential);
            setState(() {
              _isOTPGenerationInProgress = false;
            });
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
            debugPrint('verificationFailed: ${firebaseAuthException.code}');
            ToastHelper.showLongToast(firebaseAuthException.code);
            setState(() {
              _isOTPSent = false;
              _isOTPGenerationInProgress = false;
            });
          },
          codeSent: (String verificationId, int? forceResendingToken) async {
            setState(() {
              _isOTPSent = true;
              _verificationId = verificationId;
              _isOTPGenerationInProgress = false;
            });
            debugPrint('codeSent: $verificationId $forceResendingToken');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint('codeAutoRetrievalTimeout called with: $verificationId');
          });
    }
  }

  Future<void> _onVerifyOTP() async {
    if (_otpEditingController.text.trim().length < 6) {
      ToastHelper.showLongToast('Invalid OTP');
    } else if (_isOTPVerificationInProgress) {
      ToastHelper.showLongToast('Please wait');
    } else {
      try {
        setState(() {
          _isOTPVerificationInProgress = true;
        });
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _otpEditingController.text,
        );
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      } catch (e) {
        ToastHelper.showLongToast('Invalid OTP');
        setState(() {
          _isOTPVerificationInProgress = false;
        });
      }
    }
  }

//endregion
}
