import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api_calls/chat_services.dart';
import '../../ui/chat/chat_screen.dart';
import '../../models/contact.dart';
class UsersChatsList extends StatefulWidget {
  @override
  _UsersChatsListState createState() => _UsersChatsListState();
}

class _UsersChatsListState extends State<UsersChatsList> {
  final ChatServices _chatMethods = ChatServices.instance;
  Future _future;

  @override
  void initState() {
    _future = _chatMethods.getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[300],
        title: Text("Chats"),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            List<Contact> data = snapshot.data;
            return ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(ChatScreen(data[index].id.toString()));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: index.isOdd?Colors.grey[200]:Colors.grey[300],
                          trailing: Text(data[index].phone),
                          title: Text(data[index].name),

                        ),

                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: (CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
