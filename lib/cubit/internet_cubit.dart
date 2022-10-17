import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? _subscription;
  InternetCubit() : super(InternetInitial());

  void checkConnection() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        emit(ConnectedState(message: "Connected"));
      } else {
        emit(NotConnectedState(message: "Not Connected"));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
