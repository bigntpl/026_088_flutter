import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'compass.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
        const ExtractArgumentsScreen(),
      },
      // Provide a function to handle named routes.
      // Use this function to identify the named
      // route being pushed, and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Right-Way',
      home: const MyStatefulWidget(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, SingleChildScrollView ?body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            Image.asset(
                'compasshomee.png',
                  height: 200,
                  width: 250,
                ),
            ElevatedButton(
              onPressed: () {
                // When the user taps the button,
                // navigate to a named route and
                // provide the arguments as an optional
                // parameter.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavtoPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAED581)),
              ),
              child: const Text('Enter : Right Way Application'),
              // back

            ),
            // A button that navigates to a named route.
            // For this route, extract the arguments in
            // the onGenerateRoute function and pass them
            // to the screen.
            Image.asset(
                'compasshome2.png',
                height: 200,
                width: 250,
                ),
            ElevatedButton(
              onPressed: () {
                // When the user taps the button, navigate
                // to a named route and provide the arguments
                // as an optional parameter.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const History(title: '',),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAED581)),
              ),
              child: const Text('Enter :History of Compass'),
            ),
          ],
        ),
      ),
    );
  }
}
class NavtoPage extends StatelessWidget {
  const NavtoPage({Key? key, SingleChildScrollView ?body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Right-Way Navigation Page', style: TextStyle(color: Color(0xFF1B5E20))),
        backgroundColor: Color(0xFFAED581),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            ElevatedButton(
              child: const Text('Navigate to Compass Page'),
              onPressed: () {
                // When the user taps the button,
                // navigate to a named route and
                // provide the arguments as an optional
                // parameter.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Compass(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAED581)),
              ),
            ),
            // backgroundColor: Color(0xFFAED581),
            // A button that navigates to a named route.
            // For this route, extract the arguments in
            // the onGenerateRoute function and pass them
            // to the screen.
            ElevatedButton(
              child: const Text('Navigate to About Us Page'),
              onPressed: () {
                // When the user taps the button, navigate
                // to a named route and provide the arguments
                // as an optional parameter.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavtoAbout(title: '',),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAED581)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({Key? key}) : super(key: key);

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor
  // parameters. It does not extract the arguments from
  // the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute
  // function provided to the MaterialApp widget.
  const PassArgumentsScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFE65100));
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Compass(),
    Column(
        children: <Widget>[
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            '6288026 Pitipat Lertsoontornpoj',
            style: optionStyle,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Image.asset(
            'Com.jpg',
            height: 220,
            width: 220,
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            '6288088 Nattapon Lertkijroongreung',
            style: optionStyle,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Image.asset(
            'Big.jpg',
            height: 220,
            width: 220,
          ),]
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Right-Way', style: TextStyle(color: Color(0xFF1B5E20))),
        backgroundColor: const Color(0xFFAED581),
      ),
      body: Center(
        child: 
          _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFAED581),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant_navigation),
            label: 'Compass',
            backgroundColor: Color(0xFFAED581),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'About US',
            backgroundColor: Color(0xFFAED581),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF1B5E20),
        backgroundColor: Color(0xFFAED581),
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavtoAbout extends StatelessWidget {
  const NavtoAbout({Key? key, required this.title}) : super(key: key);
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFE65100));
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Right-Way AboutUs', style: TextStyle(color: Color(0xFF1B5E20))),
        backgroundColor: const Color(0xFFAED581),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                '6288026 Pitipat Lertsoontornpoj',
                style: optionStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'Com.jpg',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                '6288088 Nattapon Lertkijroongreung',
                style: optionStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'Big.jpg',
                height: 250,
                width: 250,
              ),]
        ),
      ),
    );
  }
}
class History extends StatelessWidget {
  const History({Key? key, required this.title}) : super(key: key);
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFE65100));
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Right-Way Compass History', style: TextStyle(color: Color(0xFF1B5E20))),
        backgroundColor: const Color(0xFFAED581),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
          Image.asset(
            'overview.png',
            height: 300,
            width: 350,
          ),
            const SizedBox(
                height: 10.0,
            ),
            const Text(
              'History of Compass',
              style: optionStyle,
            ),
            const SizedBox(
              height: 14.0,
            ),
            const Text(
              'The compass was invented in China during the Han Dynasty '
                  'between the 2nd century BC and 1st century AD where it was called the "south-governor" or "South Pointing Fish" (s??n??n ??????). '
                  'The magnetic compass was not, at first, used for navigation, but for geomancy and fortune-telling by the Chinese.',
               style: TextStyle (fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFFF7043)),
            ),]
        ),
      ),
    );
  }
}
