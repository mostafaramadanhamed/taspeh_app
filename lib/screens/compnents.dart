

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/counter_app/counter/counter.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/styeles/color.dart';
import 'package:tutorial/shared/styeles/strings.dart';


//start ff
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isClickable=true,
  Function ?suffixPressed,

})=>   TextFormField(
  controller: controller,
  keyboardType: type,
  enabled:isClickable ,
  validator: (s) {
    return validate(s!);
  },
  cursorColor: defaultColor,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon: suffix!=null ? IconButton(
      onPressed: ()
      {suffixPressed!();},
      icon: Icon(suffix,)
      ,): null
    ,

    border: const OutlineInputBorder(),
  ),
) ;
 defaultAppBar({
  required BuildContext context ,
  String ? title,
  List<Widget>?actions ,
})=> AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_left
    ),
  ),
title: Text(
title!,
),
  titleSpacing: 5.0,
  actions: actions,

);

Widget buildTaskItem(Map model, context) => InkWell(
  child:   Dismissible(

    key: Key(model[MyStrings.id].toString()),

    child: Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children: [

          numAndTitleHome(model, context),

          const SizedBox(

            width: 20.0,

          ),

          iconButtonDelete(context, model),

        ],

      ),

    ),

    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model[MyStrings.id]);
    },

  ),
  onTap: (){
   navigateTo(context, CounterScreen(
     num: model[MyStrings.num].toString(),
   ));

  },
);

IconButton iconButtonDelete(context, Map<dynamic, dynamic> model) {
  return IconButton(

          onPressed: () {
            AlertDialog alert = alertDialog(context, model);
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },

          icon: Icon(

            Icons.delete,

            size: 25.0,

            color: defaultColor[300],

          ),

        );
}

AlertDialog alertDialog(context, Map<dynamic, dynamic> model) {
      Widget okButton = MaterialButton(
    onPressed:  () {
      AppCubit.get(context).deleteData(

        id: model[MyStrings.id],);
      Navigator.of(context).pop();
    },
    color: defaultColor,
    textColor: defaultColor[100],
    child: const Text(MyStrings.yes,textDirection: TextDirection.rtl,),

  );
  Widget cancelButton = MaterialButton(
    onPressed:  () {
      Navigator.of(context).pop();
    },
    color: defaultColor,
    textColor: defaultColor[50],
    textTheme: ButtonTextTheme.primary,
    child: const Text(MyStrings.no,textDirection: TextDirection.rtl,),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: defaultColor[50],
    title: Text(MyStrings.delete,textDirection:TextDirection.rtl,style: TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
      color: defaultColor[400],
    ),),
    content: Text(MyStrings.deleteMessage,
      textAlign: TextAlign.center,style: TextStyle(
        color: defaultColor[500],
        fontSize:17.0,
        fontStyle: FontStyle.italic,
      ),),
    actions: [
      okButton,
      cancelButton,
    ],
    actionsAlignment: MainAxisAlignment.center,
  );
  return alert;
}

Expanded numAndTitleHome(Map<dynamic, dynamic> model, context) {
  return Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model[MyStrings.title]}',

                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: defaultColor[400],
                  fontWeight: FontWeight.w600

                )

              ),
              Text(

                '${model[MyStrings.num]}',

                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16.0,
                  color: defaultColor[300]

                )

              ),


            ],

          ),

        );
}



Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(
              Icons.menu,
              size: MediaQuery.of(context).size.width/2,
              color: defaultColor[400],
            ),
            Text(
              MyStrings.initialMessage,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: defaultColor[300],
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
    end: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: .8,
    color: defaultColor.shade200,
  ),
);


void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

