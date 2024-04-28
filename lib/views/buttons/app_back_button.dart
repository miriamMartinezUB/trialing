import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/common/set_up.dart';
import 'package:trialing/common/theme_service.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final Function? onPop;

  const AppBackButton({
    Key? key,
    this.color,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    return InkWell(
      child: Icon(
        Icons.arrow_back_ios,
        color: color ?? locator<ThemeService>().paletteColors.icons,
      ),
      onTap: () {
        if (onPop == null) {
          navigatorBloc.add(BackNavigationEvent());
        }
        onPop?.call();
      },
    );
  }
}
