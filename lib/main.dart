import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory/pages/home_page/home_page.dart';
import 'package:wei_inventory/providers/inventories_store.dart';

void main() {
  runApp(MyApp());

  // final Product nounourse = Product();
  // nounourse.name = "Nounourse";
  // nounourse.customAttributes = {"Taille": "S,M,L"};

  // final Product balaine = Product();
  // balaine.name = "Balaine";
  // balaine.customAttributes = {"Taille": "S,M,L"};

  // final Product coca = Product();
  // coca.name = "Coca";
  // coca.customAttributes = { "Quantité": "1L,2L", "gout": "Zero,Light"};

  // final Product orangina = Product();
  // orangina.name = "Orangina";
  // orangina.customAttributes = { "Quantité": "1L,2L"};

  // final Product lipton = Product();
  // lipton.name = "Lipton";
  // lipton.customAttributes = { "Quantité": "1L,2L"};

  // final Inventory peluches = Inventory();
  // peluches.name = "Peluches";
  // peluches.products.addAll([ProductStore(product: nounourse), ProductStore(product: balaine)]);

  // final Inventory boissons = Inventory();
  // boissons.name = "Boissons";
  // boissons.products.addAll([ProductStore(product: coca), ProductStore(product: orangina), ProductStore(product: lipton)]);

  // final String peluchesJson = jsonEncode(peluches.toJson());
  // final String boissonsJson = jsonEncode(boissons.toJson());

  // int breakInt = 0;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InventoriesStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,

          primaryColor: Colors.white, // These are the color of the ISATI
          accentColor: const Color(0xfff70c36),
          cardColor: Colors.white,

          appBarTheme: const AppBarTheme(
            // color:  Colors.white,
            elevation: 0,
          ),

          fontFamily: "Futura Light",
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w800, color: Colors.black87),
            headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.black87),
            subtitle1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800, color: Colors.black87)
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage()
      ),
    );
  }
}