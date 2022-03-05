import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';
import 'map_screen.dart';

class AddressScreen extends StatefulWidget {
  final String? currentPosition;

  const AddressScreen({
    Key? key,
    this.currentPosition,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: paddingAll,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButton(
                  title: 'Current Location',
                  onPressed: () {
                    navigateTo(context, const MapScreen());
                  },
                ),
                Text(widget.currentPosition ?? 'Click to get your position'),
              ],
            ),
          ),
        ));
  }
}
