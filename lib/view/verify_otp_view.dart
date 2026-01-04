import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/otp_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import 'package:pinput/pinput.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/image_view.dart';

class VerifyOtpView extends StatefulWidget {
  final int? type;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  const VerifyOtpView({
    super.key,
    this.type,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  @override
  VerifyOtpViewState createState() => VerifyOtpViewState();
}

class VerifyOtpViewState extends State<VerifyOtpView> {
  final TextEditingController _otpController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OtpProvider>(
      onModelReady: (provider) {
        provider.setData(
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          password: widget.password,
        );
        provider.startResendTimer();
      },
      builder: (context, provider, _) => Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          titleWidget: Text(
            widget.type == 1 ? 'verify_email_id'.tr() : 'enter_otp'.tr(),
          ).medium(color: ColorConstants.color363636, fontSize: 20.sp),
          onBack: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                'a_verification_code_has_been'.tr(),
              ).regular(color: ColorConstants.color363636, fontSize: 16.sp),
              SizedBox(height: 34.h),
              Center(
                child: Pinput(
                  separatorBuilder: (_) {
                    return SizedBox(width: 36.w);
                  },
                  focusNode: _pinPutFocusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _otpController,
                  length: 4,
                  onCompleted: (value) {
                    if (provider.isLoading) {
                      return;
                    }
                    provider.verifyOtp(
                      context,
                      otp: _otpController.text.trim(),
                      type: widget.type,
                    );
                  },
                  onChanged: (value) {},
                  defaultPinTheme: PinTheme(
                    width: 60.w,
                    height: 60.w,
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      color: ColorConstants.color363636,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringConstants.fontFamilyFredoka,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorConstants.colorBBBBBB,
                        width: 1.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  provider.start == 0
                      ? SizedBox()
                      : Text(provider.start.formatTime()).medium(
                          fontSize: 14.sp,
                          color: ColorConstants.color363636,
                        ),
                  Opacity(
                    opacity: provider.canResend ? 1 : 0.7,
                    child: GestureDetector(
                      onTap:
                          (provider.canResend &&
                              provider.state == ViewState.idle)
                          ? () {
                              _otpController.clear();
                              provider.resendOtp(context, widget.type);
                            }
                          : null,
                      child: Text('resend'.tr()).medium(
                        fontSize: 14.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                width: 1.sw,
                title: 'confirm'.tr(),
                isLoading: provider.isLoading,
                onClick: () {
                  if (_otpController.text.isNotEmpty &&
                      provider.isLoading &&
                      _otpController.text.length == 4) {
                    provider.verifyOtp(
                      context,
                      otp: _otpController.text.trim(),
                      type: widget.type,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
