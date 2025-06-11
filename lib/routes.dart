import 'package:get/get.dart';

import 'core/constant/app_routes.dart';
import 'view/pages/home.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: AppRoutes.home, page: () => const Home()),
];
