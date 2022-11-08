import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutorial/model/azmodel.dart';
import 'package:tutorial/shared/cubit/states.dart';

import '../../homeScreen.dart';


class AppCubit extends Cubit<AppStates> {
int num=1;
AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen()
   ];

  List<String> titles = [
    '  تسابيح   ',

  ];

  // void changeIndex(int index) {
  //   currentIndex = index;
  //   emit(AppChangeBottomNavBarState());
  // }

  late Database database;
  List<Map> newAz = [];
  // List<Map> doneTasks = [];
  // List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'az.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database
            .execute(
            'CREATE TABLE az (id INTEGER PRIMARY KEY, title TEXT, num INTEGER)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDataBase({
    required String title ,
    required   num,
  })async{
    return await database.transaction((txn)
    async {
      txn.rawInsert(
        'INSERT INTO az(title , num) VALUES("$title","$num")',
      ).then((value) {
        print('$value inserted suc');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error){
        print('error when inserting new record ${error.toString()}');
      });
      return null;
    } );
  }

  void getDataFromDatabase(database) {
     newAz = [];
    // doneTasks = [];
    // archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM az').then((value) {
      value.forEach((element) {
        newAz.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String title,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE az SET title = ? WHERE id = ?',
      [title, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM az WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  // void changeAppMode({bool ?fromShared})
  // {
  //   if (fromShared != null)
  //   {
  //     isDark = fromShared;
  //     emit(AppChangeModeState());
  //   } else
  //   {
  //     isDark = !isDark;
  //     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
  //       emit(AppChangeModeState());
  //     });
  //   }
  // }
}