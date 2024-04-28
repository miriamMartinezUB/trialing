import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/main_flow/bloc/main_flow_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/main_pages_id.dart';
import 'package:trialing/resoruces/palette_colors.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Icon(Icons.home, color: paletteColors.icons),
      ),
      onTap: () {
        BlocProvider.of<MainFlowBloc>(context).add(ChangeMainScreenEvent(itemId: MainPagesId.home));
        BlocProvider.of<NavigatorBloc>(context).add(HomeNavigationEvent());
      },
    );
  }
}
