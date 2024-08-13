import 'package:flutter/material.dart';

Positioned splashInkwell(Function()? onTap) {
  return Positioned.fill(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
