
import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/ui/account/account_view.dart';
import 'package:traer/ui/addcard/addcard_view.dart';
import 'package:traer/ui/appsettings/appsetting_view.dart';
import 'package:traer/ui/chat/chat_view.dart';
import 'package:traer/ui/fund/fund_view.dart';
import 'package:traer/ui/home/home_view.dart';
import 'package:traer/ui/intro/intro_view.dart';
import 'package:traer/ui/login/login_view.dart';
import 'package:traer/ui/main/main_view.dart';
import 'package:traer/ui/neworder/neworder_view.dart';
import 'package:traer/ui/newtrip/newtrip_view.dart';
import 'package:traer/ui/order/order_view.dart';
import 'package:traer/ui/order_history/order_history_view.dart';
import 'package:traer/ui/signup/signup_view.dart';
import 'package:traer/ui/splash/splash_view.dart';
import 'package:traer/ui/trip_history/trip_history_view.dart';
import 'package:traer/utils/appstrings.dart';


@StackedApp(routes: [
  MaterialRoute(page: SplashView , initial: true),
  MaterialRoute(page: IntroView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: MainView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: FundView),
  MaterialRoute(page: ChatView),
  MaterialRoute(page: OrderView),
  MaterialRoute(page: AccountView),
  MaterialRoute(page: NewTripView),
  MaterialRoute(page: NewOrderView),
  MaterialRoute(page: AppSettingView),
  MaterialRoute(page: OrderHistoryView),
  MaterialRoute(page: TripHistoryView),
  MaterialRoute(page: AddCardView),
],dependencies: [
  Singleton(classType : NavigationService),
  LazySingleton(classType : RestService),
  //LazySingleton(classType : SingleTickerProviderStateMixin)
])

class App{
}