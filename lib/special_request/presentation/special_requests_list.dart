import 'dart:developer';
import 'package:azhlha/special_request/data/requests_list_model.dart';
import 'package:azhlha/special_request/domain/special_request_list_services.dart';
import 'package:azhlha/special_request/presentation/add_special_request.dart';
import 'package:azhlha/special_request/presentation/special_request_chat.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/icons_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../utill/app_constants.dart';

class SpecialRequestsList extends StatefulWidget {
  const SpecialRequestsList({super.key});

  @override
  State<SpecialRequestsList> createState() => _SpecialRequestsListState();
}

class _SpecialRequestsListState extends State<SpecialRequestsList> {

  RequestsListModel? _requestsListModel;
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: ColorsManager.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsManager.backButtonIcon),
        ),
        title: Text(getTranslated(context, KeysManager.specialRequest)!, style: const TextStyle(color: ColorsManager.primary),),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddSpecialRequest())), //search button action
            icon: const Icon(IconsManager.searchIcon)
          ),
        ],
      ),
    body: LoadingOverlay(
        progressIndicator: const SpinKitSpinningLines(
        color: ColorsManager.primary,
      ),
      color: ColorsManager.primary0_1Transparency,
      isLoading: isLoading,
      child: isLoading == true ?
      Container():
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  readRecipient(),
                  const SizedBox(width: 10,),
                  const Text('Means admin respond to your request', style: TextStyle(color: ColorsManager.primary),),
                ],
              ),
              const SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => cardBuilder(context, index, AssetsManager.location, '${getTranslated(context, 'Request No.')} ${_requestsListModel!.result![index].requestNumber}', _requestsListModel!.result![index].category!.name, _requestsListModel!.result![index].familyName, _requestsListModel!.result![index].createdAt, (){} , _requestsListModel!.result![index].status!.replaceAll('_', ' ')),
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: _requestsListModel!.result!.length
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget cardBuilder(context, index, image, requestNo, type, governance, date, clearButtonAction, status) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialRequestChat(title: requestNo, specialRequestDetails: _requestsListModel!.result![index].specialRequestDetails!,))),
      child: Card(
        borderOnForeground: true,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ColorsManager.white,
        elevation: 10,
        shadowColor: ColorsManager.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: SizedBox(
          height: 130.h,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(imagePath + image), // this is a temporary image
                  backgroundColor: ColorsManager.white,
                ),
                const SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(requestNo, style: TextStyle(color: ColorsManager.deepBlue, fontWeight: FontWeight.bold, fontSize: 17.w),),
                    const SizedBox(height: 5,),
                    Text('$type - $governance', style: TextStyle(color: ColorsManager.deepBlue, fontSize: 14.w),),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(IconsManager.calenderIcon, size: 20.w,),
                        const SizedBox(width: 5,),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(date)).toString(), style: TextStyle(color: ColorsManager.deepBlue, fontSize: 14.w),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(IconsManager.processingIcon, size: 20.w,),
                        const SizedBox(width: 5,),
                        Text(status, style: TextStyle(color: ColorsManager.deepRed, fontSize: 14.w),),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorsManager.red,
                        child: IconButton(
                          onPressed: clearButtonAction, // need action
                          icon: const Icon(IconsManager.clearSoldIcon, color: ColorsManager.white,),
                        ),
                      ),
                    ),
                    readRecipient()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget readRecipient() => const CircleAvatar(
    backgroundColor: ColorsManager.green,
    radius: 7,
  );

  void loadData(){
    SpecialRequestListServices.getRequestsList(context).then((value){
      log(value.toString());
      _requestsListModel = value!;
      setState(() {
        isLoading = false;
      });
    });
  }
}
