import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/main_flow/bloc/main_flow_bloc.dart';
import 'package:trialing/features/history/history_page.dart';
import 'package:trialing/features/medication_schedule/home_page.dart';
import 'package:trialing/features/settings/settings_page.dart';
import 'package:trialing/resoruces/main_pages_id.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/texts.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final MainFlowBloc mainFlowBloc = BlocProvider.of<MainFlowBloc>(context);
    List<Widget> screens = [
      const HomePage(),
      const HistoryPage(),
      const SettingsPage(),
    ];

    return BlocBuilder<MainFlowBloc, MainFlowState>(
      bloc: mainFlowBloc,
      builder: (context, MainFlowState state) {
        return Scaffold(
          body: screens[state.itemId.index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody),
            unselectedLabelStyle: getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody),
            backgroundColor: paletteColors.card,
            unselectedItemColor: paletteColors.textSubtitle,
            selectedItemColor: paletteColors.active,
            currentIndex: state.itemId.index,
            onTap: (int indexTapped) =>
                mainFlowBloc.add(ChangeMainScreenEvent(itemId: MainPagesId.values[indexTapped])),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: translate('home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: translate('history'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: translate('settings'),
              ),
            ],
          ),
        );
      },
    );
  }
}
