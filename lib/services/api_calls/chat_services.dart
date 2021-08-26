import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../consts/firebase_consts.dart';
import '../../models/message.dart';
import '../../models/contact.dart';


class ChatServices {
  ChatServices._internal();
  static final ChatServices _chatServices = ChatServices._internal();
  static ChatServices get instance => _chatServices;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _chats =
      _firestore.collection(CHATS_COLLECTION);
  static final CollectionReference _contacts =
      _firestore.collection(CONTACTS_COLLECTION);

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<QuerySnapshot> getChats() async {
    QuerySnapshot snapshot = await _chats.get();

    return snapshot;
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    final QuerySnapshot result = await _contacts.orderBy(TIMESTAMP_FIELD).get();
    result.docs.forEach((element) {
      contacts.add(Contact.fromJson(element.data()));

    });
    return contacts;
  }

  Future<void> addMessageToDB(Message message) async {
    try {
      await _chats
          .doc(message.senderId)
          .collection(message.receiverId)
          .add(message.toMap());

      await _contacts.doc(message.senderId).set({
        'id': message.senderId,
        TIMESTAMP_FIELD: message.timestamp,
        'name': message.senderName,
        'phone':message.senderPhone
      });

      await _chats
          .doc(message.receiverId)
          .collection(message.senderId)
          .add(message.toMap());
    } catch (e) {
      print(e);
    }
  }

  ///******************* Image chat methods *****************

  Message setImageMsg(String url, String receiverId, String senderId) {
    Message msg;
    msg = Message.imageMessage(
      photoUrl: url,
      receiverId: receiverId,
      senderId: senderId,
      message: "Image",
      type: "Image",
      timestamp: Timestamp.now(),
    );
    return msg;
  }

  Future<DocumentReference> addImageToDB(Message message) {
    try {
      Map msg = message.toImageMap();
      _chats.doc(message.senderId).collection(message.receiverId).add(msg);
      final docRef =
          _chats.doc(message.receiverId).collection(message.senderId).add(msg);
      return docRef;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      StorageReference reference =
          _storage.ref().child("${DateTime.now().millisecondsSinceEpoch}");
      StorageUploadTask uploadTask = reference.putFile(image);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      var url = await storageTaskSnapshot.ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  uploadImage({
    File image,
    String receiverId,
    String senderId,
  }) async {
    uploadImageToStorage(image).then((url) {
      Message msg = setImageMsg(url, receiverId, senderId);
      addImageToDB(msg);
    });
  }
}
