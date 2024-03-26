// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i30;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i32;
import 'package:traer/models/trip_history_model.dart' as _i31;
import 'package:traer/ui/common/account/account_view.dart' as _i11;
import 'package:traer/ui/common/changepasword/change_password_view.dart'
    as _i26;
import 'package:traer/ui/common/chat/chat_view.dart' as _i9;
import 'package:traer/ui/common/editprofile/edit_profile_view.dart' as _i28;
import 'package:traer/ui/common/forgotpassword/forgot_password_view.dart'
    as _i27;
import 'package:traer/ui/common/intro/intro_view.dart' as _i3;
import 'package:traer/ui/common/login/login_view.dart' as _i4;
import 'package:traer/ui/common/signup/signup_view.dart' as _i5;
import 'package:traer/ui/common/splash/splash_view.dart' as _i2;
import 'package:traer/ui/common/uploaddocument/upload_document_view.dart'
    as _i29;
import 'package:traer/ui/customer/customer_home/customer_homeview.dart' as _i21;
import 'package:traer/ui/customer/customer_main/customer_mainview.dart' as _i20;
import 'package:traer/ui/customer/customer_order/customer_orderview.dart'
    as _i23;
import 'package:traer/ui/customer/customer_orderhistory/customer_orderhistory_view.dart'
    as _i22;
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_view.dart'
    as _i25;
import 'package:traer/ui/customer/customer_trip_history/customer_triphistory_view.dart'
    as _i24;
import 'package:traer/ui/traveler/addcard/addcard_view.dart' as _i17;
import 'package:traer/ui/traveler/appsettings/appsetting_view.dart' as _i14;
import 'package:traer/ui/traveler/edittrip/edittrip_view.dart' as _i19;
import 'package:traer/ui/traveler/fund/fund_view.dart' as _i8;
import 'package:traer/ui/traveler/home/home_view.dart' as _i7;
import 'package:traer/ui/traveler/main/main_view.dart' as _i6;
import 'package:traer/ui/traveler/neworder/neworder_view.dart' as _i13;
import 'package:traer/ui/traveler/newtrip/newtrip_view.dart' as _i12;
import 'package:traer/ui/traveler/order/order_view.dart' as _i10;
import 'package:traer/ui/traveler/order_history/order_history_view.dart'
    as _i15;
import 'package:traer/ui/traveler/trip_history/trip_history_view.dart' as _i16;
import 'package:traer/ui/traveler/tripdetail/trip_detail_view.dart' as _i18;

class Routes {
  static const splashView = '/';

  static const introView = '/intro-view';

  static const loginView = '/login-view';

  static const signUpView = '/sign-up-view';

  static const mainView = '/main-view';

  static const homeView = '/home-view';

  static const fundView = '/fund-view';

  static const chatView = '/chat-view';

  static const orderView = '/order-view';

  static const accountView = '/account-view';

  static const newTripView = '/new-trip-view';

  static const newOrderView = '/new-order-view';

  static const appSettingView = '/app-setting-view';

  static const orderHistoryView = '/order-history-view';

  static const tripHistoryView = '/trip-history-view';

  static const addCardView = '/add-card-view';

  static const tripDetailView = '/trip-detail-view';

  static const editTripView = '/edit-trip-view';

  static const customerMainView = '/customer-main-view';

  static const customerHomeView = '/customer-home-view';

  static const customerOrderHistoryView = '/customer-order-history-view';

  static const customerOrderView = '/customer-order-view';

  static const customerTripHistoryView = '/customer-trip-history-view';

  static const customerTripFilterView = '/customer-trip-filter-view';

  static const changePasswordView = '/change-password-view';

  static const forgotPaswordView = '/forgot-pasword-view';

  static const editProfileView = '/edit-profile-view';

  static const uploadDocumentView = '/upload-document-view';

  static const all = <String>{
    splashView,
    introView,
    loginView,
    signUpView,
    mainView,
    homeView,
    fundView,
    chatView,
    orderView,
    accountView,
    newTripView,
    newOrderView,
    appSettingView,
    orderHistoryView,
    tripHistoryView,
    addCardView,
    tripDetailView,
    editTripView,
    customerMainView,
    customerHomeView,
    customerOrderHistoryView,
    customerOrderView,
    customerTripHistoryView,
    customerTripFilterView,
    changePasswordView,
    forgotPaswordView,
    editProfileView,
    uploadDocumentView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.introView,
      page: _i3.IntroView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i5.SignUpView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i6.MainView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i7.HomeView,
    ),
    _i1.RouteDef(
      Routes.fundView,
      page: _i8.FundView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i9.ChatView,
    ),
    _i1.RouteDef(
      Routes.orderView,
      page: _i10.OrderView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i11.AccountView,
    ),
    _i1.RouteDef(
      Routes.newTripView,
      page: _i12.NewTripView,
    ),
    _i1.RouteDef(
      Routes.newOrderView,
      page: _i13.NewOrderView,
    ),
    _i1.RouteDef(
      Routes.appSettingView,
      page: _i14.AppSettingView,
    ),
    _i1.RouteDef(
      Routes.orderHistoryView,
      page: _i15.OrderHistoryView,
    ),
    _i1.RouteDef(
      Routes.tripHistoryView,
      page: _i16.TripHistoryView,
    ),
    _i1.RouteDef(
      Routes.addCardView,
      page: _i17.AddCardView,
    ),
    _i1.RouteDef(
      Routes.tripDetailView,
      page: _i18.TripDetailView,
    ),
    _i1.RouteDef(
      Routes.editTripView,
      page: _i19.EditTripView,
    ),
    _i1.RouteDef(
      Routes.customerMainView,
      page: _i20.CustomerMainView,
    ),
    _i1.RouteDef(
      Routes.customerHomeView,
      page: _i21.CustomerHomeView,
    ),
    _i1.RouteDef(
      Routes.customerOrderHistoryView,
      page: _i22.CustomerOrderHistoryView,
    ),
    _i1.RouteDef(
      Routes.customerOrderView,
      page: _i23.CustomerOrderView,
    ),
    _i1.RouteDef(
      Routes.customerTripHistoryView,
      page: _i24.CustomerTripHistoryView,
    ),
    _i1.RouteDef(
      Routes.customerTripFilterView,
      page: _i25.CustomerTripFilterView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i26.ChangePasswordView,
    ),
    _i1.RouteDef(
      Routes.forgotPaswordView,
      page: _i27.ForgotPaswordView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i28.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.uploadDocumentView,
      page: _i29.UploadDocumentView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.IntroView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.IntroView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.LoginView(),
        settings: data,
      );
    },
    _i5.SignUpView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SignUpView(),
        settings: data,
      );
    },
    _i6.MainView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.MainView(),
        settings: data,
      );
    },
    _i7.HomeView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.HomeView(),
        settings: data,
      );
    },
    _i8.FundView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.FundView(),
        settings: data,
      );
    },
    _i9.ChatView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ChatView(),
        settings: data,
      );
    },
    _i10.OrderView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.OrderView(),
        settings: data,
      );
    },
    _i11.AccountView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.AccountView(),
        settings: data,
      );
    },
    _i12.NewTripView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.NewTripView(),
        settings: data,
      );
    },
    _i13.NewOrderView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.NewOrderView(),
        settings: data,
      );
    },
    _i14.AppSettingView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.AppSettingView(),
        settings: data,
      );
    },
    _i15.OrderHistoryView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.OrderHistoryView(),
        settings: data,
      );
    },
    _i16.TripHistoryView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.TripHistoryView(),
        settings: data,
      );
    },
    _i17.AddCardView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.AddCardView(),
        settings: data,
      );
    },
    _i18.TripDetailView: (data) {
      final args = data.getArgs<TripDetailViewArguments>(nullOk: false);
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.TripDetailView(args.dataSource),
        settings: data,
      );
    },
    _i19.EditTripView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.EditTripView(),
        settings: data,
      );
    },
    _i20.CustomerMainView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.CustomerMainView(),
        settings: data,
      );
    },
    _i21.CustomerHomeView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.CustomerHomeView(),
        settings: data,
      );
    },
    _i22.CustomerOrderHistoryView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.CustomerOrderHistoryView(),
        settings: data,
      );
    },
    _i23.CustomerOrderView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.CustomerOrderView(),
        settings: data,
      );
    },
    _i24.CustomerTripHistoryView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.CustomerTripHistoryView(),
        settings: data,
      );
    },
    _i25.CustomerTripFilterView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i25.CustomerTripFilterView(),
        settings: data,
      );
    },
    _i26.ChangePasswordView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.ChangePasswordView(),
        settings: data,
      );
    },
    _i27.ForgotPaswordView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.ForgotPaswordView(),
        settings: data,
      );
    },
    _i28.EditProfileView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.EditProfileView(),
        settings: data,
      );
    },
    _i29.UploadDocumentView: (data) {
      return _i30.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.UploadDocumentView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TripDetailViewArguments {
  const TripDetailViewArguments({required this.dataSource});

  final _i31.Data dataSource;

  @override
  String toString() {
    return '{"dataSource": "$dataSource"}';
  }

  @override
  bool operator ==(covariant TripDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.dataSource == dataSource;
  }

  @override
  int get hashCode {
    return dataSource.hashCode;
  }
}

extension NavigatorStateExtension on _i32.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIntroView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.introView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.fundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chatView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newOrderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAppSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.appSettingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTripHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.tripHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addCardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTripDetailView({
    required _i31.Data dataSource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tripDetailView,
        arguments: TripDetailViewArguments(dataSource: dataSource),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerOrderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerOrderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerTripHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerTripHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerTripFilterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerTripFilterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPaswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgotPaswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUploadDocumentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.uploadDocumentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIntroView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.introView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.fundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chatView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.orderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newOrderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAppSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.appSettingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.orderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTripHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tripHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addCardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTripDetailView({
    required _i31.Data dataSource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tripDetailView,
        arguments: TripDetailViewArguments(dataSource: dataSource),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerOrderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerOrderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerTripHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerTripHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerTripFilterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerTripFilterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changePasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPaswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgotPaswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUploadDocumentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.uploadDocumentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
