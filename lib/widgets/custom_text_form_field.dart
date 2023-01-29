import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 5),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
