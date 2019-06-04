import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:provider/provider.dart';

class Reload{

   
  //TODO:最後再來封裝
  void reload(BuildContext context)async{//添加之後 
    final cardsBloc = Provider.of<CardsBloc>(context);
    final catalogExtraBloc =Provider.of<CatalogExtraBloc>(context);
    await cardsBloc.loadCardCompleteList();
    await catalogExtraBloc.loadCatalogExtraList();
    await catalogExtraBloc.loadCatalogExtraList2();

  }
  // static void reload(BuildContext context){
  //    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
  //   dropDownMenuCatlogState.loadCurrentCatologName(name);
  // }
}