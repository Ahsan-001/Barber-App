<<<<<<< Updated upstream:lib/Views/Landing/landing_view.dart
=======
import 'package:barber/Constants/colors.dart';
import 'package:barber/Views/Customer/Account/account_view.dart';
import 'package:barber/Views/Customer/Favorites/favt_view.dart';
import 'package:barber/Views/Customer/Inbox/inbox_view.dart';

>>>>>>> Stashed changes:lib/Views/Customer/Landing/landing_view.dart
import 'package:flutter/material.dart';

<<<<<<< Updated upstream:lib/Views/Landing/landing_view.dart
class LandingView extends StatelessWidget {
=======
import '../Home/home_view.dart';

class LandingView extends StatefulWidget {
>>>>>>> Stashed changes:lib/Views/Customer/Landing/landing_view.dart
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream:lib/Views/Landing/landing_view.dart
    return Scaffold(
      appBar: AppBar(
        title: Text('LandingView'),
      ),
    );
=======
    _buildScreens() {
      return [
        HomeView(),
        FavtView(),
        InboxView(),
        AccountView(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.house_fill),
          inactiveIcon: const Icon(Glyphicon.house),
          title: ("Home"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.suit_heart_fill),
          inactiveIcon: const Icon(Glyphicon.suit_heart),
          title: ("Wishlist"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.inbox_fill),
          inactiveIcon: const Icon(Glyphicon.inbox),
          title: ("Inbox"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.person_fill),
          inactiveIcon: const Icon(Glyphicon.person),
          title: ("Account"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
      ];
    }

    return PersistentTabView(context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: kWhiteColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        // decoration: NavBarDecoration(
        //     borderRadius: BorderRadius.circular(20.0),
        //     colorBehindNavBar: kWhiteColor),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn),
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.easeInCirc,
            duration: Duration(milliseconds: 200)),
        navBarStyle: NavBarStyle.style12);
>>>>>>> Stashed changes:lib/Views/Customer/Landing/landing_view.dart
  }
}
