import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/product_model.dart';
import 'package:patatoche_v2/provider/shop_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../helpers/common_function.dart';
import '../helpers/common_textfield.dart';
import '../widgets/image_view.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopProvider>(
      onModelReady: (provider) async {
        await provider.getProducts(context);
      },
      builder: (context, provider, _) => Scaffold(
        body: Container(
                width: 1.sw,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 15.h,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsResource.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: provider.state == ViewState.busy
                    ? Center(child: CircularProgressIndicator())
                    :  Column(
                  children: [
                    Text('shop'.tr().toUpperCase()).medium(
                      fontSize: 20.sp,
                      color: ColorConstants.color363636,
                    ),
                    SizedBox(height: 20.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: CommonTextField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.search,
                        textCapitalization: TextCapitalization.words,
                        controller: provider.searchController,
                        hintText: 'search_for_patatoche'.tr(),
                        textAlign: TextAlign.start,
                        hintColor: ColorConstants.color3D3939.withValues(
                          alpha: .8,
                        ),
                        preffix: Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                          child: ImageView(
                            path: AssetsResource.icSearch,
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 42.h,
                      margin: EdgeInsets.only(top: 20.h, bottom: 22.h),

                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 21.w),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _categoryBuilder(
                            context,
                            index,
                            provider.products.entries.toList()[index].key,
                            provider.selectedIndex,
                            provider,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 8.w);
                        },
                        itemCount: provider.products.length,
                      ),
                    ),

                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          left: 21.w,
                          right: 21.w,
                          bottom: 24.h,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 20.w,
                          childAspectRatio: 1,
                        ),
                        itemCount: provider.filteredProducts.length,
                        itemBuilder: (context, index) {
                          return _productItemBuilder(
                            context,
                            index,
                            provider.filteredProducts[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _categoryBuilder(
    BuildContext context,
    int index,
    String key,
    int selectedIndex,
    ShopProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        provider.selectedIndex = index;
      },
      child: Container(
        height: 42.h,
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.r),
          color: selectedIndex == index
              ? Theme.of(context).primaryColor
              : ColorConstants.colorFFFFFF,
        ),
        child: Text(key).medium(
          fontSize: 14.sp,
          color: selectedIndex == index
              ? ColorConstants.colorFFFFFF
              : ColorConstants.color000000,
        ),
      ),
    );
  }

  _productItemBuilder(BuildContext context, int index, Product product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorConstants.colorFFFFFF,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 9),
            blurRadius: 12.r,
            spreadRadius: -1.r,
            color: ColorConstants.color000000.withValues(alpha: .07),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 18.h, bottom: 4.h),
              child: ImageView(path: product.image ?? '', fit: BoxFit.cover,),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
            child: Row(
              children: [
                Text(
                  product.name ?? '',
                  maxLines: 1,
                ).medium(fontSize: 12.sp, color: ColorConstants.color000000),
                SizedBox(width: 8.w),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    CommonFunction.openUrl("${product.amazonUrl}");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text('buy'.tr()).semiBold(
                      fontSize: 10.sp,
                      color: ColorConstants.colorFFFFFF,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
