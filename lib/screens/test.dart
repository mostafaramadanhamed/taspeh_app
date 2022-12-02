
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/screens/compnents.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/cubit/states.dart';
import 'package:tutorial/shared/styeles/color.dart';
import 'package:tutorial/shared/styeles/strings.dart';

class AzLayoutScreen extends StatefulWidget {
  const AzLayoutScreen({Key? key}) : super(key: key);

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
            key: scaffoldKey,
            appBar: AppBar(
              title: Center(
                child: Text(
                  cubit.titles[cubit.currentIndex],style:const TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: defaultColor,
                  fontFamily: 'Marhey',
                ),textAlign: TextAlign.center,
                ),
              ),

            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDataBase(
                    title: titleController.text,
                    num: numController.text,
                  );
                }
              }
              else {
                scaffoldKey.currentState!.showBottomSheet(
                      (context) =>
                      Container(
                        color: defaultColor[50],
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
                                      return MyStrings.validateTitle;
                                    }
                                    return null;
                                  },
                                  label: MyStrings.titleT,
                                  prefix: Icons.title,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  controller: numController,
                                  type: TextInputType.number,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return MyStrings.validateNum;
                                    }
                                    return null;
                                  },
                                  label: MyStrings.numT,
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
          );
        },

      ),
    );
  }
}

