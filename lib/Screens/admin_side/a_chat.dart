
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Refactoring/methods/app_bar_cuper.dart';
import '../../Refactoring/styles/colors.dart';
import '../../controller/chat_controller.dart';

class AChat extends StatelessWidget {
  const AChat({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    return Scaffold(
      appBar: customAppBar(null, null, null, 'CHAT'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: bgColor,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextFormField(
                    controller: chatController.messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      suffixIcon: Obx(() {
                        return chatController.showSendButton.value
                            ? IconButton(
                                onPressed: () {
                                
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color:kBlack
                                ),
                              )
                            : const SizedBox.shrink();
                      }),
                      hintText: 'Type a message',
                      border: InputBorder.none,
                      prefixIconColor: Colors.grey,
                      prefixIcon: const Icon(Icons.emoji_emotions),
                    ),
                    onChanged: chatController.onTextChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
