import 'package:flutter/material.dart';

abstract final class AafiatakRadii {
  const AafiatakRadii._();

  static const double xsValue = 4;
  static const double controlValue = 6;
  static const double smValue = 8;
  static const double mdValue = 12;
  static const double lgValue = 16;
  static const double xlValue = 24;
  static const double searchValue = 28;
  static const double fullValue = 999;

  static const xs = BorderRadius.all(Radius.circular(xsValue));
  static const control = BorderRadius.all(Radius.circular(controlValue));
  static const sm = BorderRadius.all(Radius.circular(smValue));
  static const md = BorderRadius.all(Radius.circular(mdValue));
  static const lg = BorderRadius.all(Radius.circular(lgValue));
  static const xl = BorderRadius.all(Radius.circular(xlValue));
  static const search = BorderRadius.all(Radius.circular(searchValue));
  static const full = BorderRadius.all(Radius.circular(fullValue));

  static const button = md;
  static const input = md;
  static const card = lg;
  static const dialog = xl;
  static const bottomSheet = BorderRadius.vertical(
    top: Radius.circular(searchValue),
  );
}
