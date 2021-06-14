import 'package:flutter/material.dart';

Map<String, RangeValues> getConstraints()
{
  var constraints = <String, RangeValues>{};

  constraints['rating'] = RangeValues(0, 5);
  constraints['calories'] = RangeValues(0.0, 2000.0);
  constraints['protein'] = RangeValues(0.0, 100.0);
  constraints['fat'] = RangeValues(0.0, 100.0);
  constraints['sodium'] = RangeValues(0.0, 100.0);
  constraints['price'] = RangeValues(0.0, 1000.0);

  return constraints;
}