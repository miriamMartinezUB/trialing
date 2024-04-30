import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/buttons/app_text_button.dart';
import 'package:trialing/views/texts.dart';

class ShowMyDialog {
  final String title;
  final String? text;
  final List<ContentAction>? actions;

  late final Color _colorActions;

  ShowMyDialog({
    required this.title,
    this.text,
    this.actions,
  });

  Future<void> show(BuildContext context) async {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _colorActions = paletteColors.active;
    List<ContentAction>? actions = this.actions;

    actions ??= [
      ContentAction(
        textAction: 'accept',
        onPress: () {
          navigatorBloc.add(CloseNavigationEvent());
        },
      ),
    ];

    final List<Widget> customActions = _getActions(actions, _colorActions);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: paletteColors.card,
          title: AppText(
            translate(title),
            type: TextTypes.smallBodyMedium,
          ),
          content: text == null
              ? null
              : AppText(
                  translate(text!),
                  type: TextTypes.smallBodyLight,
                ),
          actions: customActions,
        );
      },
    );
  }

  List<Widget> _getActions(List<ContentAction> actions, Color colorActions) {
    List<Widget> result = [];
    for (ContentAction contentAction in actions) {
      result.add(
        AppTextButton(
          text: contentAction.textAction,
          onTap: contentAction.onPress,
          color: contentAction.color ?? _colorActions,
          shouldTranslate: true,
        ),
      );
    }
    return result;
  }
}

class ContentAction {
  final String textAction;
  final Color? color;
  final Function() onPress;

  ContentAction({required this.textAction, required this.onPress, this.color});
}
