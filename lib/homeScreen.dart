import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/cubit/states.dart';

import 'compnents.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,state){},
      builder: (context, state){
        return tasksBuilder(tasks: AppCubit.get(context).newAz,);
      },

    );
  }
}
