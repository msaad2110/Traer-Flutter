
import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/ui/common/account/account_view.dart';
import 'package:traer/ui/common/addcard/addcard_view.dart';
import 'package:traer/ui/common/cards_list/cardslist_view.dart';
import 'package:traer/ui/common/changepasword/change_password_view.dart';
import 'package:traer/ui/common/chat/chat_view.dart';
import 'package:traer/ui/common/chat_users/chat_users_view.dart';
import 'package:traer/ui/common/editprofile/edit_profile_view.dart';
import 'package:traer/ui/common/forgotpassword/forgot_password_view.dart';
import 'package:traer/ui/common/fund/fund_view.dart';
import 'package:traer/ui/common/intro/intro_view.dart';
import 'package:traer/ui/common/login/login_view.dart';
import 'package:traer/ui/common/signup/signup_view.dart';
import 'package:traer/ui/common/splash/splash_view.dart';
import 'package:traer/ui/common/uploaddocument/upload_document_view.dart';
import 'package:traer/ui/customer/customer_home/customer_homeview.dart';
import 'package:traer/ui/customer/customer_main/customer_mainview.dart';
import 'package:traer/ui/customer/customer_order/customer_orderview.dart';
import 'package:traer/ui/customer/customer_orderhistory/customer_orderhistory_view.dart';
import 'package:traer/ui/customer/customer_track_order/customer_track_order_view.dart';
import 'package:traer/ui/customer/customer_trip_detail/customer_trip_detailview.dart';
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_view.dart';
import 'package:traer/ui/customer/customer_trip_history/customer_triphistory_view.dart';
import 'package:traer/ui/traveler/appsettings/appsetting_view.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_view.dart';
import 'package:traer/ui/traveler/home/home_view.dart';
import 'package:traer/ui/traveler/main/main_view.dart';
import 'package:traer/ui/traveler/neworder/neworder_view.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_view.dart';
import 'package:traer/ui/traveler/order/order_view.dart';
import 'package:traer/ui/traveler/order_history/order_history_view.dart';
import 'package:traer/ui/traveler/order_status/order_status_view.dart';
import 'package:traer/ui/traveler/trip_history/trip_history_view.dart';
import 'package:traer/ui/traveler/tripdetail/trip_detail_view.dart';
import 'package:traer/utils/appstrings.dart';


@StackedApp(routes: [
  MaterialRoute(page: SplashView , initial: true),
  MaterialRoute(page: IntroView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: MainView),
  MaterialRoute(page: HomeView ),
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
  MaterialRoute(page: TripDetailView),
  MaterialRoute(page: EditTripView),
  MaterialRoute(page: CustomerMainView),
  MaterialRoute(page: CustomerHomeView),
  MaterialRoute(page: CustomerOrderHistoryView),
  MaterialRoute(page: CustomerOrderView),
  MaterialRoute(page: CustomerTripHistoryView),
  MaterialRoute(page: CustomerTripFilterView),
  MaterialRoute(page: ChangePasswordView),
  MaterialRoute(page: ForgotPaswordView),
  MaterialRoute(page: EditProfileView),
  MaterialRoute(page: UploadDocumentView),
  MaterialRoute(page: CustomerTripDetailView),
  MaterialRoute(page: CustomerTrackOrderView),
  MaterialRoute(page: OrderStatusView),
  MaterialRoute(page: ChatUsersView),
  MaterialRoute(page: CardslistView),
],dependencies: [
  Singleton(classType : NavigationService),
  LazySingleton(classType : RestService),
  //LazySingleton(classType : SingleTickerProviderStateMixin)
])

class App{
}