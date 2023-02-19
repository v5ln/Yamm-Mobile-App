import '../views/form_view.dart';
import '../views/orders_view.dart';
import '../views/settings_view.dart';

class NavBarViewModel {
  final int? index;
  static const String routeId = '/';
  get getScreens => screens;
  final screens = [
    OrderView(),
    FormScreen(),
    // SettingsView()
    // OrderView(),
    // const FormScreen(),
    // const SettingsScreen(),
  ];
  NavBarViewModel({this.index = 1});
}
