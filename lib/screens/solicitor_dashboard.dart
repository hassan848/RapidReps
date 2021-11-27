// ignore_for_file: file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'export.dart';
import '../utilities/export.dart';
import '../widgets/export.dart';

class SolicitorDashboard extends StatefulWidget {
  final SolicitorModel currentUser;

  const SolicitorDashboard({Key? key, required this.currentUser})
      : super(key: key);

  @override
  _SolicitorDashboardState createState() => _SolicitorDashboardState();
}

class _SolicitorDashboardState extends State<SolicitorDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;
  late bool? freelance = widget.currentUser.freelancer;
  late String? mobileNumber = widget.currentUser.mobileNumber;
  late String? telephoneNumber = widget.currentUser.telephoneNumber;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard ${widget.currentUser.userType}'),
        centerTitle: true,
        backgroundColor: kCDOColour,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      // widget goes here, need to know which one the team wants to go with for the dashboard
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      // display map here
                      const Text(
                        "Map Page",
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConstructionPage(),
                              ),
                            );
                          },
                          child: const Icon(Icons.list),
                          backgroundColor: kCDOColour,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "${widget.currentUser.firstName?.capitalize()} ${widget.currentUser.lastName?.capitalize()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      getFirmDetails(freelance, widget.currentUser.firm),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Experience: ${widget.currentUser.experience}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: mobileNumber != null ? 25 : 0,
                      ),
                      getNumber(mobileNumber),
                      SizedBox(
                        height: mobileNumber != null ? 25 : 0,
                      ),
                      getNumber(telephoneNumber),
                      SizedBox(
                        height: telephoneNumber != null ? 25 : 0,
                      ),
                      Text(
                        "${widget.currentUser.email}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      customIconButton(
                        context,
                        label: 'Edit',
                        backgroundColour: kCDOColour,
                        horizontalPadding: 35,
                        icon: Icons.edit,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConstructionPage(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      customIconButton(
                        context,
                        label: 'Logout',
                        backgroundColour: Colors.red,
                        horizontalPadding: 25,
                        icon: Icons.logout,
                        onPressed: () => logout(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index,
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(
              Icons.apps,
            ),
            title: const Text(
              'Jobs Taken',
            ),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.location_pin,
            ),
            title: const Text(
              'Map',
            ),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.people,
            ),
            title: const Text(
              'Profile',
            ),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
