import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

import '../enums/view_state.dart';
import '../helpers/common_function.dart';
import '../helpers/common_textfield.dart';
import '../provider/activation_code_provider.dart';
import '../provider/add_spotify_playlist_provider.dart';

class AddSpotifyPlaylistView extends StatefulWidget {
  final String spotifyUrl;

  const AddSpotifyPlaylistView({super.key, required this.spotifyUrl});

  @override
  AddSpotifyPlaylistViewState createState() => AddSpotifyPlaylistViewState();
}

class AddSpotifyPlaylistViewState extends State<AddSpotifyPlaylistView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _urlController = TextEditingController(text: widget.spotifyUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddSpotifyPlaylistProvider>(
      builder: (context, provider, _) => Padding(
        // Add bottom padding to avoid keyboard overlap
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: 1.sw,
          padding: EdgeInsets.only(top: 26.h, left: 21.w, right: 21.w),
          decoration: BoxDecoration(
            color: ColorConstants.colorFFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68.w,
                  height: 68.w,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorConstants.colorFFFFFF,
                        ColorConstants.colorFFF4E3,
                      ],
                    ),
                    border: Border.all(
                      color: ColorConstants.colorFFECCE,
                      width: 1.w,
                    ),
                  ),
                  child: ImageView(path: AssetsResource.icSpotify, width: 99.w),
                ),
                SizedBox(height: 20.h),
                Text(
                  'add_spotify_playlist'.tr(),
                ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
                /* SizedBox(height: 12.h),

                Text(
                  ''.tr(),
                ).regular(
                  fontSize: 14.sp,
                  color: ColorConstants.color363636,
                  textAlign: TextAlign.center,
                ),*/
                SizedBox(height: 12.h),

                CommonTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter_spotify_playlist_url'.tr();
                    } else if (!CommonFunction.isValidSpotifyUrl(value)) {
                      return 'invalid_url'.tr();
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  controller: _urlController,
                  hintText: 'enter_spotify_playlist_url'.tr(),
                  textAlign: TextAlign.start,
                  onFieldSubmitted: (value) async {
                    if (_formKey.currentState!.validate()) {
                      context.hideKeyboard();
                      context.pop(_urlController.text.trim());
                    }
                  },
                ),

                SizedBox(height: 20.h),
                PrimaryButton(
                  width: 1.sw,
                  isLoading: provider.state == ViewState.busy,
                  title: 'submit'.tr(),
                  onClick: () async {
                    if (_formKey.currentState!.validate()) {
                      context.hideKeyboard();
                      context.pop(_urlController.text.trim());
                    }
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
