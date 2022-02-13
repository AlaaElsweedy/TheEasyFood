import 'package:flutter/material.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';
import 'map_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: paddingAll,
          child: Center(
            child: DefaultButton(
              title: 'Gurrent Location',
              onPressed: () {
                navigateTo(context, const MapScreen());
              },
            ),
          ),
        ));
  }
}
