import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/main_flow/bloc/main_flow_bloc.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/main_pages_id.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/texts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final MainFlowBloc bloc = BlocProvider.of<MainFlowBloc>(context);
    return SafeArea(
      child: Drawer(
        backgroundColor: paletteColors.background,
        child: BlocBuilder<MainFlowBloc, MainFlowState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
                    child: Column(
                      children: [
                        DrawerItem(
                          text: translate('home'),
                          iconData: Icons.home_outlined,
                          color: paletteColors.icons,
                          onTap: () => bloc.add(ChangeMainScreenEvent(itemId: MainPagesId.home)),
                        ),
                        DrawerItem(
                          text: translate('history'),
                          iconData: Icons.history,
                          color: paletteColors.icons,
                          onTap: () => bloc.add(ChangeMainScreenEvent(itemId: MainPagesId.history)),
                        ),
                        DrawerItem(
                          text: translate('settings'),
                          iconData: Icons.settings,
                          color: paletteColors.icons,
                          onTap: () => bloc.add(ChangeMainScreenEvent(itemId: MainPagesId.settings)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function() onTap;
  final Color? color;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;

    return InkWell(
      onTap: onTap,
      splashColor: paletteColors.primary,
      child: Column(
        children: [
          ListTile(
            title: AppText(
              translate(text),
              type: TextTypes.body,
              color: color,
            ),
            leading: Icon(
              iconData,
              color: color,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
