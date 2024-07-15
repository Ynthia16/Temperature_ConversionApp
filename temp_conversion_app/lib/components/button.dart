import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MyButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 5, 4, 5),
      child: SizedBox(
        height: 30,
        width: 150,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                foregroundColor: Colors.white,
                elevation: 5.5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                textStyle: const TextStyle(
                  fontSize: 18,
                )),
            child: const Text(
              'Convert',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
      ),
    );
  }
}
