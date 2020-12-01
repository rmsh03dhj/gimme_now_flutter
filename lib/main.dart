import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimme_now_flutter/core/config/gimme_now_routes.dart';
import 'package:gimme_now_flutter/core/service_locator.dart' as di;
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gimme_now_flutter/splash_screen.dart';

import 'core/navigation_service.dart';
import 'core/simple_bloc_delegate.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_event.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'features/registration_or_login/presentation/pages/confirmation_code_entry_page.dart';
import 'features/registration_or_login/presentation/pages/register_or_login_page_wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Bloc.observer = SimpleBlocDelegate();

  runApp(RunApp());
}

class RunApp extends StatefulWidget {
  RunApp({Key key}) : super(key: key);

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartBloc>(
      create: (context) => sl<AppStartBloc>()..add(CheckForAuthentication()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationOrLoginBloc>(
            create: (context) => sl<RegistrationOrLoginBloc>(),
          ),
          BlocProvider<DashBoardBloc>(
            create: (context) => sl<DashBoardBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: sl<NavigationService>().navigationKey,
          debugShowCheckedModeBanner: false,
          routes: _registerRoutes(),
          onGenerateRoute: _registerRoutesWithParameters,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    GimmeNowRoutes.signUp: (context) => _buildRegistrationOrLoginBloc(),
    GimmeNowRoutes.home: (context) => SplashScreen(),
  };
}

BlocProvider<RegistrationOrLoginBloc> _buildRegistrationOrLoginBloc() {
  return BlocProvider<RegistrationOrLoginBloc>(
    create: (context) => sl<RegistrationOrLoginBloc>(),
    child: RegistrationOrLoginPageWrapper(),
  );
}

Route _registerRoutesWithParameters(RouteSettings settings) {
  if (settings.name == GimmeNowRoutes.code) {
    final user = settings.arguments;
    return MaterialPageRoute(
      settings: RouteSettings(
        name: GimmeNowRoutes.code,
      ),
      builder: (context) {
        return ConfirmCodeEntryPageWrapper(user);
      },
    );
  }if (settings.name == GimmeNowRoutes.dashboard) {
    final email = settings.arguments;
    return MaterialPageRoute(
      settings: RouteSettings(
        name: GimmeNowRoutes.dashboard,
      ),
      builder: (context) {
        return DashBoardPageWrapper(email);
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        return RegistrationOrLoginPageWrapper();
      },
    );
  }
}
