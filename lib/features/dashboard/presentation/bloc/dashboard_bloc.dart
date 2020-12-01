
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gimme_now_flutter/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {


  DashBoardBloc() : super(DashboardInitialState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadProfile) {
      yield DashboardLoadedState(event.user);
    }    if (event is UpdateProfile) {
      yield DashboardLoadedState(event.user);
    }
  }
}

