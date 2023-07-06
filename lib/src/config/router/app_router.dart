//! Recuerda importar el paquete de go_router 
import 'package:go_router/go_router.dart';
import 'package:weather_v2/src/featured/screens/home/home_screen.dart';

final router = GoRouter(
initialLocation: '/',
  routes: [
    GoRoute(
      path: '/', 
      name: HomeScreen.name, 
      builder: (context, state) => const HomeScreen(),
      // routes: [
      // //?Sub-rutas del home, se usa para el deeplinking 
      // ]
    ),
    //* GoRoute(
    //*   path: '/', 
    //*   name: routeName.name, 
    //*   builder: (context, state) => const routeName(),
    //* ),
  ]
);