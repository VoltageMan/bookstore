import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/chat/bloc/chat_bloc.dart';
import 'package:bookstore/features/chat/bloc/chat_events.dart';
import 'package:bookstore/helpers/modal_sheets.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/theme.dart';

class TypeAndSend extends StatefulWidget {
  const TypeAndSend({
    Key? key,
  }) : super(key: key);

  @override
  State<TypeAndSend> createState() => _TypeAndSendState();
}

class _TypeAndSendState extends State<TypeAndSend> {
  bool isTextEmpty = true;
  bool isVoice = true;

  final TextEditingController _text = TextEditingController();

  void changeValue(String v) {
    setState(() {
      isTextEmpty = v.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChatBloc>(context);

    return BottomAppBar(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: TextField(
              controller: _text,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.darkBlue,
                fontSize: 15.sp,
              ),
              decoration: const InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
              onChanged: changeValue,
            ),
          ),
          IconButton(
            onPressed: () async {
              ModelBottomSheetHelper.showCameraOrGallerySelector(context);
            },
            icon: const Icon(
              Icons.attach_file,
            ),
          ),
          IconButton(
            onPressed: () {
              bloc.add(
                SendMessageEvent(
                  message: _text.text,
                ),
              );
              _text.clear();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
