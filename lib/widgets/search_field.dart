import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search items",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ))
      ],
    );
  }
}
