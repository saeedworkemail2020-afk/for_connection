import 'package:for_connection/Featuers/Home/home_model.dart';
// import 'package:for_connection/Featuers/Home/home_services.dart';

class HomeController {
  late HomeModel _model;
  // late HomeServices _services;
  HomeController() {
    _model = HomeModel();
    // _services = HomeServices();
  }
  HomeModel get model => _model;
  // HomeServices get services => _services;
}
