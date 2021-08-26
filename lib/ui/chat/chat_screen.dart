import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common_widgets/cached_image.dart';
import '../../consts/firebase_consts.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/image_helpers.dart';
import '../../models/message.dart';
import '../../services/api_calls/chat_services.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  ChatScreen(this.receiverId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isWriting = false;
  final ChatServices _chatMethods = ChatServices.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SettingsController _settingsCon = Get.find<SettingsController>();

  // String _currentUserId = 'oeBBdsy8VZcMQqzdPu8J';
  String _currentUserId = Get.find<UserController>().currentUser.id.toString();
  UserController _userController= Get.find<UserController>();

  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("chat".tr),
        centerTitle: true,
        backgroundColor: _settingsCon.color1,
      ),
      body: Stack(
        children: [
          buildMessagesStream(),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _textFieldController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (val) {
                        if (val.length > 0 && val.trim() != "") {
                          setState(() {
                            isWriting = true;
                          });
                        } else {
                          setState(() {
                            isWriting = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "type_here".tr,
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                            borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        filled: true,
                        isDense: true,
                        fillColor: _settingsCon.color1.withOpacity(.5),
                      ),
                    ),
                  ),
                  isWriting
                      ? SizedBox()
                      : IconButton(
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            color: _settingsCon.color1,
                            size: 28,
                          ),
                        ),
                  isWriting
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              sendMessage();
                            },
                            child: CircleAvatar(
                              radius: 22,
                              child: Icon(
                                Icons.send,
                                color: _settingsCon.color1,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    File selectedImage = await getImage(imageSource);
    _chatMethods.uploadImage(
      image: selectedImage,
      senderId: _currentUserId,
      receiverId: widget.receiverId,
    );
  }

  sendMessage() {
    String text = _textFieldController.text;
    Message message = Message(
      senderName: _userController.currentUser.firstName,
      senderPhone: _userController.currentUser.phone,
      receiverId: widget.receiverId,
      message: text,
      senderId: _currentUserId,
      timestamp: Timestamp.now(),
    );
    setState(() {
      isWriting = false;
      _textFieldController.clear();
    });
    _chatMethods.addMessageToDB(message);
  }

  buildMessagesStream() {
    return StreamBuilder(
      stream: _firestore
          .collection(CHATS_COLLECTION)
          .doc(_currentUserId)
          .collection(widget.receiverId)
          .orderBy(TIMESTAMP_FIELD, descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom:55.0),
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 50, top: 70),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                return chatMessageItem(snapshot.data.docs[index]);
              },
            ),
          );
        }
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data.call());

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: _message.senderId == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserId
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }

  getMessage(Message message) {
    String msgType = message.type;
    return msgType == "Image"
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedImage(
              message.photoUrl,
              height: 300,
              width: 300,
              radius: 10,
              notFromOurApi: true,
              fit: BoxFit.cover,
            ),
          )
        : Text(
            message.message,
            style: TextStyle(

              fontSize: 16.0,
            ),
          );
  }

  Widget senderLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12, right: 4),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: _settingsCon.color1.withOpacity(.5),
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  Widget receiverLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12, left: 4),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.blueGrey[400],
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }
}
