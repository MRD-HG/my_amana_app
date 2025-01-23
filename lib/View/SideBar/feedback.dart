import "../Menu/MenuSide.dart";


import 'package:flutter/material.dart';

void main() {
  runApp(const FeedB());
}

class FeedB extends StatelessWidget {
  const FeedB({super.key});

  
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: const CheckboxPage(),
      routes: {
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        '/page3': (context) => const Page3(),
        '/page4': (context) => const Page4(),
      },
    );
  }
}

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  List<bool> checkboxes = [false, false, false, false];

  void navigateToCheckedPages() {
    List<String> checkedPages = [];

    for (int i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i]) {
        checkedPages.add('/page${i + 1}');
      }
    }

    if (checkedPages.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiPageViewer(pages: checkedPages),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer:darweF(context),
      body: Column(
        children: [
          CheckboxListTile(
            title:const Text("Formulaire du Feedback sur l'Agence"),
            value: checkboxes[0],
            onChanged: (value) {
              setState(() {
                checkboxes[0] = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text( "Feedback sur l'expérience de l'application mobile My Amana "),
            value: checkboxes[1],
            onChanged: (value) {
              setState(() {
                checkboxes[1] = value!;
              });
    
    
    
            },
          ),
          CheckboxListTile(
            title: const Text("Feedback sur l'expérience de l'application le call centre "),
            value: checkboxes[2],
            onChanged: (value) {
              setState(() {
                checkboxes[2] = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text("Feedback sur l'expérience de livraison à domicile"),
            value: checkboxes[3],
            onChanged: (value) {
              setState(() {
                checkboxes[3] = value!;
              });
            },
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(7),
            child: ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              fixedSize:const Size(350, 20)
            ),
              onPressed: navigateToCheckedPages,
              
              child: const Text('Navigate'),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiPageViewer extends StatefulWidget {
  final List<String> pages;

  const MultiPageViewer({super.key, required this.pages});

  @override
  _MultiPageViewerState createState() => _MultiPageViewerState();
}

class _MultiPageViewerState extends State<MultiPageViewer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Page Viewer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: widget.pages
                  .map((page) => Navigator(
                        onGenerateRoute: (settings) =>
                            MaterialPageRoute(builder: (context) => PageRouter(page: page)),
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: previousPage,
                icon: const Icon(Icons.arrow_back),
              ),
              Text('${_currentPage + 1}/${widget.pages.length}'),
              IconButton(
                onPressed: nextPage,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PageRouter extends StatelessWidget {
  final String page;

  const PageRouter({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: page,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/page1':
            builder = (BuildContext context) => const Page1();
            break;
          case '/page2':
            builder = (BuildContext context) => const Page2();
            break;
          case '/page3':
            builder = (BuildContext context) => const Page3();
            break;
          case '/page4':
            builder = (BuildContext context) => const Page4();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: const Center(
        child: Text('This is Page 1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const Center(
        child: Text('This is Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: const Center(
        child: Text('This is Page 3'),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 4'),
      ),
      body: const Center(
        child: Text('This is Page 4'),
      ),
    );
  }
}
