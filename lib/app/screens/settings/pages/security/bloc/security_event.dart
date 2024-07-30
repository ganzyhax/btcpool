part of 'security_bloc.dart';

@immutable
sealed class SecurityEvent {}

class SecurityLoad extends SecurityEvent {}

class SecurtiyOn extends SecurityEvent {}

class SecurtiyOff extends SecurityEvent {}
