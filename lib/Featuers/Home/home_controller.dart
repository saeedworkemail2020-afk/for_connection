import 'package:for_connection/Featuers/Home/home_model.dart';

class HomeController {
  late HomeModel _model;
  HomeController() {
    _model = HomeModel();
  }
  HomeModel get model => _model;
}
