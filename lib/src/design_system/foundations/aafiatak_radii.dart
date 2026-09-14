import 'package:flutter/material.dart';

abstract final class AafiatakRadii {
  const AafiatakRadii._();

  static const double smValue = 8;
  static const double mdValue = 12;
  static const double lgValue = 16;
  static const double xlValue = 24;
  static const double fullValue = 999;

  // Numeric aliases
  static const double radius8 = smValue;
  static const double radius12 = mdValue;
  static const double radius16 = lgValue;
  static const double radius24 = xlValue;
  static const double radiusFull = fullValue;

  static const sm = BorderRadius.all(Radius.circular(smValue));
  static const md = BorderRadius.all(Radius.circular(mdValue));
  static const lg = BorderRadius.all(Radius.circular(lgValue));
  static const xl = BorderRadius.all(Radius.circular(xlValue));
  static const full = BorderRadius.all(Radius.circular(fullValue));

  static const button = md;
  static const input = md;
  static const card = lg;
  static const dialog = xl;
  static const bottomSheet = BorderRadius.vertical(
    top: Radius.circular(xlValue),
  );
}
