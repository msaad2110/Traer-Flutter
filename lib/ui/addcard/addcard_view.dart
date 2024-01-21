

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/ui/addcard/addcard_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/loading_button.dart';

class AddCardView extends StackedView<AddCardViewModel>{


  @override
  Widget builder(BuildContext context, AddCardViewModel viewModel, Widget? child) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: true,
        onPopInvoked: (value){
          print(value);

        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Add Funds", onBackClicked: () {
            }),
            body: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardFormField(
                      controller: viewModel.controller,
                      countryCode: 'US',
                      enablePostalCode: true,
                      style: CardFormStyle(
                        borderColor: Colors.blueGrey,
                        textColor: Colors.black,
                        placeholderColor: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: LoadingButton(
                      onPressed: viewModel.controller.details.complete == true ? () => _handlePayPress(viewModel: viewModel) : null,// Pass parameter: null,
                      text: 'Add Card',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title,
      {required Function() onBackClicked}) {
    return CustomAppBar(
        title: AppbarSubtitleThree(
            text: title, margin: EdgeInsets.only(left: 14)));
  }

  @override
  AddCardViewModel viewModelBuilder(BuildContext context) {
    return AddCardViewModel();
  }


  @override
  void onViewModelReady(AddCardViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getClientSecret(StackedService.navigatorKey!.currentContext!, viewModel , UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0); // Call API after first build
    });
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  getClientSecret(BuildContext context, AddCardViewModel viewModel , int userID) {
    CustomLoader.showLoader(context);
    viewModel.getClientSecret(userID).then((value) {
      CustomLoader.hideLoader(context);

      if (value.success ?? false) {
        print(value.data?.client_secret ?? "");
        viewModel.clientSecretModel = value;
      } else {
        CustomDialog.showErrorDialog(context, onPressedDialog: (){
          Navigator.pop(context);
          locator<NavigationService>().clearStackAndShow(Routes.mainView);
        });
      }

    }).catchError((onError) {
      print(onError.toString());
      CustomLoader.hideLoader(context);
      CustomDialog.showErrorDialog(context, onPressedDialog: (){
        Navigator.pop(context);
        locator<NavigationService>().clearStackAndShow(Routes.mainView);

      });
      print(onError.toString());
    });
    // locator<NavigationService>().navigateTo(Routes.splashView);
  }

  Future<void> _handlePayPress({required AddCardViewModel viewModel}) async {

    if (!viewModel.controller.details.complete) {
      return;
    }

    // 1. fetch Intent Client Secret from backend
    final clientSecret = viewModel.clientSecretModel.data?.client_secret;

    print(clientSecret);

    // 2. Gather customer billing information (ex. email)
    final billingDetails = BillingDetails(
      email: "mussadiqc@gmail.com",
      phone: '+48888000888',
      address: Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    ); // mo mocked data for tests

    // 3. Confirm payment with card details
    // The rest will be done automatically using webhooks
    // ignore: unused_local_variable
    final setupIntentResult = await Stripe.instance.confirmSetupIntent(
      paymentIntentClientSecret: clientSecret!,
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: billingDetails,
        ),
      ),
    );

    print(setupIntentResult.toJson());

    ScaffoldMessenger.of(StackedService.navigatorKey!.currentContext!).showSnackBar(SnackBar(
        content: Text('Success!: The payment was confirmed successfully!')));
  }
}