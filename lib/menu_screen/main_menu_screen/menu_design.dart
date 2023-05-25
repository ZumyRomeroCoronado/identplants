import 'package:flutter/material.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/menu_screen.dart';
import 'package:provider/provider.dart';

class MenuDesign extends StatelessWidget {
  const MenuDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegationModele(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navegation(),
      ),
    );
  }
}

class _Navegation extends StatelessWidget {
  const _Navegation();

  @override
  Widget build(BuildContext context) {
    final navegationModele = Provider.of<_NavegationModele>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      fixedColor: const Color.fromRGBO(39, 171, 165, 1),
      unselectedLabelStyle:
          const TextStyle(color: Color.fromRGBO(4, 35, 26, 1), fontSize: 14),
      unselectedItemColor: AppTheme.primary,
      currentIndex: navegationModele.pageActual,
      
      onTap: (i) => {
        navegationModele.pageActual = i
      },
      items: const [
        /*    BottomNavigationBarItem(
          icon: Icon(
            //Icons.fmd_good_rounded,
            Icons.home,
            size: 32,
          ),
          label: 'Inicio',
        ), */
        BottomNavigationBarItem(
          backgroundColor: AppTheme.primary,
          icon: Icon(
            Icons.camera_alt_rounded,
            size: 32,
          ),
          label: 'Identificar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.local_florist_rounded,
            size: 32,
          ),
          label: 'Plantas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32,
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navegationModele = Provider.of<_NavegationModele>(context);
    return PageView(
      //  physics: NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        navegationModele.pageActual = value;
      },
      controller: navegationModele.pageController,
      children: const [
        // HomeDesign(),
        IdPlantDesign(),
        ReportPlantsDesign(),
        ProfileDesign(),
      ],
    );
  }
}

class _NavegationModele with ChangeNotifier {
  int _pageActual = 0;
  final PageController _pageController = PageController();
  int get pageActual => _pageActual;
  set pageActual(int valor) {
    _pageController.animateToPage(
      valor,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    _pageActual = valor;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
