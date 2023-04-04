import 'package:hive/hive.dart';
import 'package:water_tracker/models/category/database.dart';

class Boxes {
  static Box<WaterModel> getdata() => Hive.box<WaterModel>('category');
}
