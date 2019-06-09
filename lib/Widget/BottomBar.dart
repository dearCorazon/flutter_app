import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/Provider/BottomNavagatiorState.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttomNavigatorState = Provider.of<BottonBarState>(context);
    final dropbloc= Provider.of<DropDownMenuBloc>(context);
    return Container(
      child: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.redAccent,
        currentIndex: buttomNavigatorState.index,
        onTap: (index) async {
          buttomNavigatorState.loadIndex(index);
          dropbloc.loadInformation();
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.amberAccent,
              ),
              title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), title: Text("案例")),
          //BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text("统计")),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: Text("我的")),
        ],
      ),
    );
  }
}
