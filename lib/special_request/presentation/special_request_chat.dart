import 'dart:developer';

import 'package:azhlha/special_request/data/message_model.dart';
import 'package:azhlha/special_request/data/requests_list_model.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../utill/app_constants.dart';
import '../../utill/icons_manager.dart';

class SpecialRequestChat extends StatefulWidget {
  late String title;
  late List<SpecialRequestDetails> specialRequestDetails;
  SpecialRequestChat({super.key, required this.title, required this.specialRequestDetails});

  @override
  State<SpecialRequestChat> createState() => _SpecialRequestChatState();
}

class _SpecialRequestChatState extends State<SpecialRequestChat> {
  final TextEditingController _chatController = TextEditingController();
  late final List<SpecialRequestDetails> messages;

  @override
  void initState() {
    messages = widget.specialRequestDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsManager.backButtonIcon),
        ),
        title: Text(widget.title, style: const TextStyle(color: ColorsManager.primary),),
        actions: [
          IconButton(
              onPressed: (){}, //search button action
              icon: const Icon(IconsManager.searchIcon)
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    reverse: true,
                    itemBuilder:(context, index) => index == 0
                        ? _fileDownloadBuilder((){})
                        : _fullChatBody(messages[index]),
                    itemCount: messages.length,
                  ),
                ),
                _chatInputBuilder(),
              ],
            )
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
    setState(() {
      if(_chatController.text.isNotEmpty) {
        //messages.insert(0, Messages_Model(_chatController.text, DateTime.now()));
        _chatController.clear();
      }
    });
  }

  Widget _fullChatBody(SpecialRequestDetails model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: model.role == 'admin admin'? CrossAxisAlignment.start:CrossAxisAlignment.end,
      children: [
        model.role == 'admin admin'?_senderHeader(model.createdAt):_receiverHeader(model.createdAt),
        const SizedBox(height: 20,),
        _chatTextBuilder(model.content)
      ],
    ),
  );

  Widget _senderHeader(date) => Row(
    children: [
      CircleAvatar(
        backgroundColor: ColorsManager.black, //background image needs to be adjusted
        radius: 30.h,
      ),
      const SizedBox(width: 10,),
      Text(date),
    ],
  );

  Widget _receiverHeader(date) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(date),
      const SizedBox(width: 10,),
      CircleAvatar(
        backgroundColor: ColorsManager.black, //Background Image needs to be adjusted
        radius: 30.h,
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
