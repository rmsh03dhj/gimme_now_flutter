import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gimme_now_flutter/features/registration_or_login/data/models/user.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';
import 'package:gimme_now_flutter/features/utils/gimme_now_button.dart';
import 'package:gimme_now_flutter/features/utils/gimme_now_scaffold_with_drawer.dart';
import 'package:gimme_now_flutter/features/utils/gimme_now_text_form_field.dart';
import 'package:gimme_now_flutter/features/utils/validators.dart';

class DashBoardPageWrapper extends StatelessWidget {
  final String email;

  const DashBoardPageWrapper(this.email);
  @override
  Widget build(BuildContext context) {
    return GimmeNowScaffoldWithDrawer(
      body: DashBoardPage(email),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  final String email;
  DashBoardPage(this.email);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 16,
              ),
              Text("Welcome to the app ${widget.email}", style: TextStyle(fontSize: 16),),
            ],
          ),
        );
      },
    );
  }

  void dispose() {
    super.dispose();
  }
}