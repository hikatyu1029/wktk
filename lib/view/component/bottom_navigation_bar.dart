import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ミックスイン：クラスのコードを複数のクラス階層で再利用する方法です。
// ミックスインするにはwithキーワードに続けて1つ以上のつ以上のクラスを指定します。
// ChangeNotifierをmixinするだけで、ViewModelとして機能します。
// ロジック実行後にnotifyListeners()を呼ぶことで、View側に変更を通知できます。

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    // View側に変更を通知
    notifyListeners();
  }
}

class WktkBottomNavigationBar extends StatelessWidget {
  const WktkBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = Provider.of<BottomNavigationBarProvider>(context);

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: bottomNavProvider.currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (value) {
        bottomNavProvider.currentIndex = value;
      },
    );
  }
}
