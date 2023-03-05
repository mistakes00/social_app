import 'package:flutter/material.dart';
import 'package:social_app/custom_widgets/custom_input.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 70),
        child: Column(
          children: [
            const Text(
              'Search',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w400,
              ),
            ),
            CustomTextFormField(
              onChanged: (value) {},
              unVisibly: true,
              hintText: 'Search all photos',
            ),
          ],
        ),
      ),
    );
  }
}
