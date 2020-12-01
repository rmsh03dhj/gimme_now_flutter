import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppStartState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AppStartState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AppStartState {
  Authenticated();
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AppStartState {
  @override
  String toString() => 'Unauthenticated';
}

class FreeSomeSpaceState extends AppStartState {
  @override
  String toString() => 'FreeSomeSpaceState';
}

class AppStartErrorState extends AppStartState {
  final String errorMessage;

  AppStartErrorState(this.errorMessage);
  @override
  String toString() => 'AppStartErrorState';
}

class UpdateRequiredState extends AppStartState {
  @override
  String toString() => 'UpdateRequiredState';
}

class AmplifyConfiguringFailed extends AppStartState {
  final String errorMessage;

  AmplifyConfiguringFailed(this.errorMessage);
  @override
  String toString() => 'AmplifyConfiguringFailed';
}

class AmplifyConfigured extends AppStartState {
  @override
  String toString() => 'AmplifyConfigured';
}
