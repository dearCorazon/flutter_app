import 'package:flutter/material.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO:需要优化一下表格
    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dropDownMenuCatlogState.getCurrentCardList.length,
      itemBuilder: (BuildContext context,int index){
        return Table(
          children: [
            TableRow(
              children: [
                Text(dropDownMenuCatlogState.getCurrentCardList[index].question),
                Text(dropDownMenuCatlogState.getCurrentCardList[index].answer),
                ],
          ),],
        );
      },

    );
  }
}