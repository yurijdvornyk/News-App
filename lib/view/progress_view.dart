
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

get progressIndicator {
  return Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
}