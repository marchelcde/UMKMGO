import 'package:flutter/material.dart';

// Define the roles. 'none' is for when no one is logged in.
enum UserRole { buyer, seller, admin, none }

// A simple class to hold our user data
class AppUser {
  final String email;
  UserRole role; // Role can change (e.g., buyer upgrades to seller)

  AppUser({required this.email, required this.role});
}

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  UserRole get userRole => _currentUser?.role ?? UserRole.none;

  // Mock login function
  Future<void> login(String email, String password) async {
    // In a real app, you would check Firebase Auth here.
    if (email.toLowerCase() == 'buyer@test.com') {
      _currentUser = AppUser(email: email, role: UserRole.buyer);
    } else if (email.toLowerCase() == 'seller@test.com') {
      _currentUser = AppUser(email: email, role: UserRole.seller);
    }
    // --- NEW MOCK USER FOR SIGNUP ---
    else if (email.toLowerCase() == 'newuser@test.com') {
      _currentUser = AppUser(email: email, role: UserRole.buyer);
    }
    // ---------------------------------
    else {
      // Failed login
      _currentUser = null;
    }
    notifyListeners();
  }

  // This fulfills your requirement: "unless they make a seller account"
  Future<void> upgradeToSeller() async {
    if (_currentUser != null && _currentUser!.role == UserRole.buyer) {
      _currentUser!.role = UserRole.seller;
      notifyListeners();
      // In a real app, you would update this in Firestore/your DB
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
}