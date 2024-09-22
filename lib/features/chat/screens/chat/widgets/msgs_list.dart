import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/chat/bloc/chat_bloc.dart';
import 'package:bookstore/features/chat/bloc/chat_events.dart';
import 'package:bookstore/features/chat/models/message.dart';
import 'package:bookstore/features/chat/screens/chat/widgets/chat_date_widget.dart';
import 'package:bookstore/features/chat/screens/chat/widgets/msg_time.dart';
import 'package:bookstore/features/chat/screens/chat/widgets/msg_wrapper.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/settings/consts.dart';

class MsgsList extends StatefulWidget {
  const MsgsList({
    Key? key,
    required this.msgs,
  }) : super(key: key);

  final Set<Message> msgs;

  @override
  State<MsgsList> createState() => _MsgsListState();
}

class _MsgsListState extends State<MsgsList> {
  late ScrollController listController;
  late ChatBloc chatBloc;

  @override
  void initState() {
    chatBloc = BlocProvider.of(context);
    listController = ScrollController();
    listController.addListener(() {
      if (listController.position.maxScrollExtent == listController.offset &&
          chatBloc.state.currentPage != null) {
        chatBloc
            .add(GetMessagesListEvent(chatBloc.state.currentPage! + 1, true));
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MsgsList oldWidget) {
    messageList = widget.msgs.toList();
    super.didUpdateWidget(oldWidget);
  }

  late var messageList = widget.msgs.toList();
  @override
  Widget build(BuildContext context) {
    return messageList.isEmpty
        ? SizedBox()
        : ListView.separated(
            separatorBuilder: (context, index) {
              return (index != 0 &&
                      messageList[index].date != messageList[index - 1].date)
                  ? ChatDateWidget(text: messageList[index].date)
                  : SizedBox();
            },
            reverse: true,
            padding: EdgeInsets.only(bottom: 50.h),
            controller: listController,
            physics: BouncingScrollPhysics(),
            itemCount: widget.msgs.length + 1,
            itemBuilder: (context, index) {
              if (index == messageList.length) {
                return ChatDateWidget(text: messageList.first.date);
              }
              final msg = messageList[index];
              return MessageWrapper(msg: msg);
            },
          );
  }
}
