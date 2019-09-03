import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/utils/colors.dart';

import 'main/home_page.dart';
import 'main/library_page.dart';
import 'main/notes_page.dart';
import 'main/record_reading_page.dart';
import 'main/settings_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (currentIndex) {
      case 0:
        currentPage = HomePage();
        break;
      case 1:
        currentPage = LibraryUserPage();
        break;
      case 2:
        currentPage = RecordReadingPage();
        break;
      case 3:
        currentPage = NotesPage();
        break;
      case 4:
        currentPage = SettingsPage();
        break;
      default:
        currentPage = HomePage();
        break;
    }

    void _onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AntIcons.book_outline),
            title: Text('Lendo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AntIcons.unordered_list),
            title: Text('Livros lidos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AntIcons.play_circle),
            title: Text('Ler'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AntIcons.bell),
            title: Text('Lembretes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AntIcons.setting_outline),
            title: Text('Configurações'),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: accentColor,
        onTap: _onItemTapped,
      ),
      body: currentPage,
    );
  }
}
