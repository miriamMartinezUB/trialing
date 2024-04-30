import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/main_flow/bloc/main_flow_bloc.dart';
import 'package:trialing/views/texts.dart';

class SingleSelectQuestionView extends StatelessWidget {
  final List<String> values;
  final String? initialValue;
  final Function(String value) onChange;

  const SingleSelectQuestionView({
    Key? key,
    required this.values,
    required this.initialValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainFlowBloc mainFlowBloc = BlocProvider.of<MainFlowBloc>(context);
    int group = initialValue == null ? 0 : values.indexOf(initialValue!);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: values.length,
      itemBuilder: (context, index) {
        String value = values[index];
        return Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.all(locator<ThemeService>().paletteColors.primary),
              value: index,
              groupValue: group,
              onChanged: (index) {
                onChange(value);
                if (!kIsWeb) {
                  mainFlowBloc.add(RefreshMainScreenEvent());
                }
              },
            ),
            Expanded(
              child: AppText(
                translate(value),
                type: TextTypes.smallBody,
              ),
            ),
          ],
        );
      },
    );
  }
}
