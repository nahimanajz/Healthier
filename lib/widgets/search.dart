import 'package:flutter/material.dart';
import 'package:healthier/utils/color_schemes.g.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchWidget(
      {super.key,
      required this.text,
      required this.hintText,
      required this.onChanged});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: lightColorScheme.scrim);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: lightColorScheme.background,
        icon: Icon(Icons.search, color: lightColorScheme.primary),
        suffixIcon: widget.text.isNotEmpty
            ? GestureDetector(
                child: Icon(Icons.close, color: lightColorScheme.primary),
                onTap: () {
                  controller.clear();
                  widget.onChanged('');
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              )
            : null,
        labelText: widget.hintText,
        hintStyle: style,
      ),
    );
  }
}
