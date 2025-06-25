// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Assuming singup.dart contains SignUpScreen
// For demonstration, I'm including SignUpScreen here.
// In a real project, keep it in singup.dart and import it.
// import 'singup.dart'; // Uncomment this and remove SignUpScreen definition below if you have a separate file.

// Existing imports for Home_Page
import 'heatwave.dart'; // Placeholder for Heatwave screen
import 'contacts.dart'; // Placeholder for Contacts screen
import 'gps.dart'; // Placeholder for GPS screen
import 'report.dart'; // Placeholder for Report screen

// --- Start of MyApp and SplashScreen (unchanged as per previous request) ---
void main() => runApp(DevicePreview(builder: (context) => const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ammu App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/next': (context) => const SignUpScreen(),
        '/home': (context) => const Home_Page(), // Added route for Home_Page
      },
      home: const SplashScreen(), // Your SplashScreen remains as the initial home page
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer to navigate to Home_Page after splash screen
    // Timer(const Duration(seconds: 3), () { // Reduced to 3 seconds for easier testing
    //   Navigator.pushReplacementNamed(context, '/home'); // Changed to '/home'
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Your existing SplashScreen UI - unchanged
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 37, 66),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset('images/ammu_girl.png', fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AMMU',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Move With Mother Care',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder SignUpScreen (as per previous context, if not in singup.dart)
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ammu App SignUp'),
        backgroundColor: const Color.fromARGB(255, 2, 37, 66),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('This is the SignUp Screen content.'),
      ),
    );
  }
}

// --- End of MyApp and SplashScreen ---


// Fixed version of home.dart with Drawer added
class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<Widget> _pages;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(_controller);

    // Initialize pages after animation is created
    _pages = [
      HomeScreen(animation: _animation),
      const GPSTrackingScreen(), // Ensure these are const if their content is static
      const Center(child: Text('Reports Page Content')), // Changed for clarity
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: const Color(0xFF00224C),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      // This onPressed already opens the drawer!
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); // This line handles opening the drawer
                      },
                      icon: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        // Action for more_vert icon
                      },
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // The Drawer widget is correctly defined here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Remove default padding
          children: <Widget>[
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 2, 37, 66),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ammu User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Menu Items for the Drawer
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to the Home page or close drawer if already on Home
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 0; // Set index to Home
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.navigation),
              title: const Text('GPS Tracking'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 1; // Set index to GPS
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Reports'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 2; // Set index to Reports
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contacts'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.waves),
              title: const Text('Heatwave'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Heatwave()));
              },
            ),
            const Divider(), // A visual separator
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add navigation to settings page
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add navigation to about page
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add logout logic
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.navigation), label: 'GPS'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Reports'),
        ],
      ),
    );
  }
}

// External widget: HomeScreen
class HomeScreen extends StatelessWidget {
  final Animation<double> animation;
  const HomeScreen({required this.animation, super.key});

  // FIXED: Moved _buildRipple into HomeScreen as a static method
  static Widget _buildRipple(double size, double opacity, Animation<double> animation) {
    return Container(
      width: size * animation.value,
      height: size * animation.value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(opacity - (animation.value * opacity)),
      ),
    );
  }

  // FIXED: Moved _buildHelpLinebutton into HomeScreen as a static method
  static Widget _buildHelpLinebutton(String imagePath, String label) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.asset(imagePath, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Note:',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF00224C),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Once you tap the button, alert message will be sent to contacts, police, staff incharge and camera will turn ON',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 51, 49, 49),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          HomeScreen._buildRipple(150, 0.6, animation),
                          HomeScreen._buildRipple(200, 0.5, animation),
                          HomeScreen._buildRipple(250, 0.4, animation),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text(
                                'SOS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Tap the SOS button for help',
                  style: TextStyle(
                    color: Color(0xFF00224C),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00224C),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    'Add All Contacts',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('NearBy Helpline', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text('Tap to Call', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF00224C))),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HomeScreen._buildHelpLinebutton('images/police.png', 'Police'),
                      HomeScreen._buildHelpLinebutton('images/family.png', 'Family'),
                      HomeScreen._buildHelpLinebutton('images/ambulance.png', '108'),
                      HomeScreen._buildHelpLinebutton('images/staff.png', 'Staff'),
                      HomeScreen._buildHelpLinebutton('images/ngo.png', 'NGO'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Indicators', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Heatwave()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE2D66C), Color(0xFFF0AC54)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.sunny, color: Colors.red, size: 22),
                        SizedBox(width: 8),
                        Text('HeatWave', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



