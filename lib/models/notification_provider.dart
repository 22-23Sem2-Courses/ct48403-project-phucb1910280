import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  int _notificationCount = 0;

  getNotificationCount() => _notificationCount;

  loadUserNotificationCount() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('XBusCustomers')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('userNotifications')
        .where('daDoc', isEqualTo: 'chua')
        .get();
    _notificationCount = snapshot.docs.length;
    notifyListeners();
  }

  markRead() {
    if (_notificationCount > 0) {
      _notificationCount--;
      notifyListeners();
    }
  }

  resetUserNotificationCount() {
    _notificationCount = 0;
    notifyListeners();
  }
}
