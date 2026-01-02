import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class FeedB extends StatelessWidget {
  const FeedB({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckboxPage();
  }
}

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  final List<bool> checkboxes = [false, false, false, false];

  void navigateToCheckedPages() {
    final List<String> checkedPages = [];

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selectionnez au moins un formulaire.')),
      );
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feedback',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Choisissez les formulaires a remplir.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String label, int index) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 12)),
      value: checkboxes[index],
      activeColor: AppColors.primary,
      onChanged: (value) {
        setState(() {
          checkboxes[index] = value ?? false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Formulaires disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCheckboxTile(
                    "Formulaire du Feedback sur l'Agence",
                    0,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'exp«∏rience de l'application mobile My Amana ",
                    1,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'exp«∏rience de l'application le call centre ",
                    2,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'exp«∏rience de livraison «ˇ domicile",
                    3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: navigateToCheckedPages,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Continuer'),
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
  State<MultiPageViewer> createState() => _MultiPageViewerState();
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
        title: const Text('Formulaires'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: widget.pages
                  .map((page) => Navigator(
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => PageRouter(page: page),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousPage,
                  icon: const Icon(Icons.arrow_back),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentPage + 1}/${widget.pages.length}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
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
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Agence',
                  subtitle: 'Parlez-nous de votre passage en agence.',
                );
            break;
          case '/page2':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Application',
                  subtitle: 'Votre avis sur l experience My Amana.',
                );
            break;
          case '/page3':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Call Center',
                  subtitle: 'Comment evalueriez-vous notre support ?',
                );
            break;
          case '/page4':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Livraison',
                  subtitle: 'Partagez votre experience de livraison.',
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppGradients.hero,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Votre retour',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Nom et prenom',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Votre message',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Envoyer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
