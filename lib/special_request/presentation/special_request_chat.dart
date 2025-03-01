import 'dart:developer';

import 'package:azhlha/special_request/data/message_model.dart';
import 'package:azhlha/special_request/data/requests_list_model.dart';
import 'package:azhlha/special_request/domain/special_request_list_services.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../utill/app_constants.dart';
import '../../utill/icons_manager.dart';

class SpecialRequestChat extends StatefulWidget {
  late String title;
  late int index;
  late RequestsListModel request;
  SpecialRequestChat({super.key, required this.title, required this.index, required this.request});

  @override
  State<SpecialRequestChat> createState() => _SpecialRequestChatState();
}

class _SpecialRequestChatState extends State<SpecialRequestChat> {
  final TextEditingController _chatController = TextEditingController();
  late final List<SpecialRequestDetails> messages;

  @override
  void initState() {
    messages = widget.request.result![widget.index].specialRequestDetails!;
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow the Scaffold to resize
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsManager.backButtonIcon),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: ColorsManager.primary),
        ),
        actions: [
          IconButton(
            onPressed: () {}, // search button action
            icon: const Icon(IconsManager.searchIcon),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: ListView.builder(
              //physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) => _fullChatBody(messages[index]),
              itemCount: messages.length,
            ),
          ),
          // Use KeyboardVisibilityBuilder to detect when the keyboard is shown
          KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return AnimatedPadding(
                padding: EdgeInsets.only(
                  bottom: isKeyboardVisible?300:0,
                ),
                duration: const Duration(milliseconds: 380),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _fileDownloadBuilder(() {}),
                      _chatInputBuilder(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  Widget _chatInputBuilder() => Padding(
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      controller: _chatController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsManager.primary),
            borderRadius: BorderRadius.circular(10)
        ),
        hintText: getTranslated(context, KeysManager.typeHere)!,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(onPressed: () => _sendMessage(), icon: const Image(image: AssetImage(imagePath + AssetsManager.send,), width: 25, height: 25,),),
      ),
      style: const TextStyle(color: ColorsManager.black),
      cursorHeight: 30.h,
      cursorColor: ColorsManager.primary,
    ),
  );

  Widget _fileDownloadBuilder(onTap){
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getTranslated(context, KeysManager.fileDownload)!),
          const SizedBox(width: 5,),
          const Image(image: AssetImage(imagePath+ AssetsManager.downloadIcon)),
        ],
      ),
    );
  }

  _sendMessage()
  {
    if(_chatController.text.isNotEmpty) {
      setState(() {
        messages.insert(messages.length, SpecialRequestDetails(id: widget.request.result![widget.index].id, role: 'user', content: _chatController.text, createdAt: DateTime.now().toString()));
        SpecialRequestListServices.sendMessage(context, widget.request.result![widget.index].id, _chatController.text);
        _chatController.clear();

      });
    }
  }

  Widget _fullChatBody(SpecialRequestDetails model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: model.role == 'admin'? CrossAxisAlignment.start:CrossAxisAlignment.end,
      children: [
        model.role == 'admin admin'?_adminHeader(model.createdAt):_userHeader(model.createdAt),
        const SizedBox(height: 20,),
        _chatTextBuilder(model.content)
      ],
    ),
  );

  Widget _adminHeader(date) => Row(
    children: [
      CircleAvatar(
        backgroundColor: ColorsManager.grey,
        radius: 31.h,
        child: CircleAvatar(
          backgroundColor: ColorsManager.white,
          radius: 30.h,
          child: const Text('A', style: TextStyle(fontSize: 28, color: ColorsManager.primary),),
        ),
      ),
      const SizedBox(width: 10,),
      Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date))),
    ],
  );

  Widget _userHeader(date) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date))),
      const SizedBox(width: 10,),
      CircleAvatar(
        backgroundColor: ColorsManager.grey,
        radius: 31.h,
        child: CircleAvatar(
          backgroundColor: ColorsManager.white,
          radius: 30.h,
          child: const Text('U', style: TextStyle(fontSize: 28, color: ColorsManager.primary),),
        ),
      ),
    ],
  );

  Widget _chatTextBuilder(text) => Container(
    decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.grey.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(10),
        color: ColorsManager.grey1.withOpacity(0.1)
    ),
    width: 0.85.sw,
    padding: const EdgeInsets.all(15),
    child: Align(
        alignment: Alignment.center,
        child: Text(text)
    ),
  );

}
