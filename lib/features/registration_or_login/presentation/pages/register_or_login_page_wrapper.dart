import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gimme_now_flutter/core/navigation_service.dart';
import 'package:gimme_now_flutter/core/routes/gimme_now_routes.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_event.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_state.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';
import 'package:gimme_now_flutter/features/utils/gimme_now_button.dart';
import 'package:gimme_now_flutter/features/utils/gimme_now_text_form_field.dart';
import 'package:gimme_now_flutter/features/utils/validators.dart';

class RegistrationOrLoginPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegistrationOrLoginPage(),
    );
  }
}

class RegistrationOrLoginPage extends StatefulWidget {
  RegistrationOrLoginPage();

  @override
  _RegistrationOrLoginPageState createState() => _RegistrationOrLoginPageState();
}

class _RegistrationOrLoginPageState extends State<RegistrationOrLoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  final _navigateService = sl<NavigationService>();
  bool _signIn = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationOrLoginBloc, RegistrationOrLoginState>(
        listener: (context, state) {
      if (state is SignUpFailedState) {
        Scaffold.of(context)
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
      }
      if (state is SignInFailedState) {
        Scaffold.of(context)
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
      }
      if (state is SignInSuccessState) {
        _navigateService.navigateToAndReplace(GimmeNowRoutes.dashboard, arguments: state.email);
      }
      if (state is ConfirmRegistrationStepState) {
        _navigateService.navigateToAndReplace(GimmeNowRoutes.code, arguments: state.user);
      }
    }, child: SingleChildScrollView(
      child:
          BlocBuilder<RegistrationOrLoginBloc, RegistrationOrLoginState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/logo_small.png",
                  scale: 5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GimmeNowFormBuilderTextField(
                              attribute: email,
                              controller: _emailController,
                              enableSuggestions: false,
                              autoCorrect: false,
                              validators: [Validators.required(), Validators.emailValidator()],
                              label: email,
                              prefixIcon: Icon(Icons.person),
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _emailFocusNode,
                              onChanged: (val) {
                                setState(() {
                                  _formKey.currentState.fields[email].currentState.validate();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GimmeNowFormBuilderTextField(
                              attribute: password,
                              decoration: InputDecoration(
                                labelText: password,
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                focusedErrorBorder:
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              controller: _passwordController,
                              obscureText: _passwordVisible,
                              validators: [Validators.required(), Validators.length()],
                              keyboardType: TextInputType.text,
                              focusNode: _passwordFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (val) {
                                setState(() {
                                  _formKey.currentState.fields[password].currentState.validate();
                                });
                              },
                            ),
                          ),
                          !_signIn
                              ? GimmeNowFormBuilderTextField(
                                  attribute: confirmPassword,
                                  decoration: InputDecoration(
                                    labelText: confirmPassword,
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.blue)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _confirmPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _confirmPasswordVisible = !_confirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  controller: _confirmPasswordController,
                                  obscureText: _confirmPasswordVisible,
                                  validators: [
                                    Validators.confirmPasswordMatchWithPassword(
                                        _passwordController.text)
                                  ],
                                  keyboardType: TextInputType.text,
                                  focusNode: _confirmPasswordFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      _formKey.currentState.fields[confirmPassword].currentState
                                          .validate();
                                    });
                                  },
                                )
                              : Container(),
                          Container(
                            height: 16,
                          ),
                          BlocBuilder<RegistrationOrLoginBloc, RegistrationOrLoginState>(
                              builder: (context, state) {
                            return GimmeNowButton(
                              text: _signIn ? signIn : signUp,
                              showCircularProgressIndicator:
                                  (state is RegistrationOrLoginProcessingState) ? true : false,
                              showTickSymbol:
                                  (state is SignInSuccessState || state is SignUpSuccessState)
                                      ? true
                                      : false,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (_signIn) {
                                    BlocProvider.of<RegistrationOrLoginBloc>(context).add(
                                        SignInPressed(
                                            _emailController.text, _passwordController.text));
                                  } else {
                                    BlocProvider.of<RegistrationOrLoginBloc>(context).add(
                                        SignUpPressed(
                                            _emailController.text, _passwordController.text));
                                  }
                                }
                              },
                            );
                          }),
                          Container(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _signIn = !_signIn;
                                  });
                                },
                                child: Text(
                                  _signIn ? signUp : signIn,
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }

  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
