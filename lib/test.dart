
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/compnents.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/cubit/states.dart';

class AzLayoutScreen extends StatefulWidget {
  @override
  State<AzLayoutScreen> createState() => _AzLayoutScreenState();
}

class _AzLayoutScreenState extends State<AzLayoutScreen> {
  var scaffoldKey =GlobalKey<ScaffoldState>();
  var formKey =GlobalKey<FormState>();
  var titleController=TextEditingController();
  var numController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.brown[50],
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.brown[50],
              title: Center(
                child: Text(
                  cubit.titles[cubit.currentIndex],style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,

                ),textAlign: TextAlign.center,
                ),
              ),

            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDataBase(
                    title: titleController.text,
                    num: numController.text,
                  );
                  // insertToDataBase(
                  //   title: titleController.text,
                  // //   time: timeController.text,
                  // //   date: dateController.text,
                  // // ).then((value) {
                  // //   getData(database).then((value) {
                  // //     Navigator.pop(context);
                  // //     // setState(() {
                  //     //   isBottomSheetShown = false;
                  //     //   fabIcon = Icons.edit;
                  //     //   tasks = value;
                  //     //   print(value);
                  //     // });
                  //   });
                  // });
                }
              }
              else {
                scaffoldKey.currentState!.showBottomSheet(
                      (context) =>
                      Container(
                        color: Colors.brown[50],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return ' يرجى ادخال تسبيحة  ';
                                    }
                                    return null;
                                  },
                                  label: ' تسبيحة  ',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  controller: numController,
                                  type: TextInputType.number,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return ' يرجى ادخال عدد';
                                    }
                                    return null;
                                  },
                                  label: ' العدد',
                                  prefix: Icons.numbers,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  elevation: 20.0,
                ).closed.then((value) {
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                titleController.clear();
                numController.clear();
              }
            },
                child: Icon(cubit.fabIcon)
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //     type: BottomNavigationBarType.fixed,
            //     currentIndex: AppCubit.get(context).currentIndex,
            //     onTap: (index){
            //       // setState((){
            //       cubit.changeIndex(index);
            //       // });
            //       print(index);
            //     },
            //     items: [
            //       BottomNavigationBarItem(icon: Icon(
            //         Icons.menu,
            //       ),
            //         label: 'Task',
            //       ),
            //       BottomNavigationBarItem(icon: Icon(
            //         Icons.check_circle_outline,
            //       ),
            //         label: 'Done',
            //       ),
            //       BottomNavigationBarItem(icon: Icon(
            //         Icons.archive_outlined,
            //       ),
            //         label: 'Archievd',
            //       ),
            //
            //     ]
            // ),
          );
        },

      ),
    );
  }
}
    // Widget buildItem ()=> SingleChildScrollView(
  //   child: InkWell(
  //     onTap: (){
  //       navigateTo(context, CounterScreen());
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: 8.0,
  //         vertical: 10.0
  //       ),
  //       child: Container(
  //         color: Colors.grey[300],
  //         width: double.infinity,
  //         height: 100,
  //         child: Row(
  //           children: [
  //              Column(
  //                children:  [
  //                  Text(
  //                     'Az1',
  //                   maxLines: 2,
  //                   textDirection: TextDirection.rtl,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 25.0,
  //             fontWeight: FontWeight.bold,
  //             overflow: TextOverflow.ellipsis,
  //                   ),),
  //
  //                  SizedBox(
  //                    height: 10.0,
  //                  ),
  //                  Text(
  //                     ' 111 ',
  //                   maxLines: 1,
  //                   textDirection: TextDirection.rtl,
  //                   style: TextStyle(
  //                     color: Colors.grey,
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.w500,
  //                     overflow: TextOverflow.ellipsis,
  //
  //                   ),
  //                   ),
  //                ],
  //              ),
  //
  //             Expanded(
  //               child: Row(
  //                 children: [
  //                   const Spacer(),
  //                   CircleAvatar(
  //                     backgroundColor: Colors.teal,
  //
  //                     child: IconButton(onPressed: (){
  //
  //
  //                     },
  //                         icon: const Icon(
  //                           Icons.add,
  //                           size: 24.0,
  //                         )),
  //
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //           ],
  //
  //
  //       ),
  //     ),
  //   ),
  //   ),
  // );

