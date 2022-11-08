

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutorial/counter_app/counter/counter.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/styeles/color.dart';


Widget defaultButton({
  double width = double.infinity ,
  Color background = Colors.blue,
  bool isUpperCase =true,
  double r =10.0,
  double height =40.0,
  required Function onPressed,
  required String text,
}) =>   Container(

  width: width,
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(r),
    color: background,
  ),
  child: MaterialButton(

    onPressed:(){
      onPressed();
    }  ,
    child:Text(
      isUpperCase ? text.toUpperCase():text,
      style:   const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: Colors.white,
      ),
    ) ,
  ),

);

Widget defaultTextButton ({
  required Function function,
  required String text,
})=> TextButton(
    onPressed: (){
      function();
    },
    child: Text(text.toUpperCase()));
//start ff
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword=false,
  IconData? suffix,
  VoidCallback ? onSubmit,
  VoidCallback ? onTap,
  VoidCallback ? onChanged,
  bool isClickable=true,
  Function ?suffixPressed,

})=>   TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled:isClickable ,
  // onFieldSubmitted: (v){
  //   onSubmit!();
  // },
  // onTap: (){
  //   onTap!();
  // },
  // onChanged: (s){
  //   onChanged!();
  // },
  validator: (s) {
    return validate(s!);
  },
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

    key: Key(model['id'].toString()),

    child: Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children: [

          // CircleAvatar(

          //   radius: 40.0,

          //   child: Text(

          //     '${model['num']}',

          //   ),

          // ),

          // SizedBox(

          //   width: 20.0,

          // ),

          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  '${model['title']}',

                  style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.brown[400],
                    fontWeight: FontWeight.w600

                  )

                ),
                Text(

                  '${model['num']}',

                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 16.0,
                    color: Colors.brown[300]

                  )

                ),


              ],

            ),

          ),

          const SizedBox(

            width: 20.0,

          ),

          // IconButton(

          //   onPressed: () {

          //     AppCubit.get(context).updateData(

          //       status: 'done',

          //       id: model['id'],

          //     );

          //   },

          //   icon: Icon(

          //     Icons.check_box,

          //     color: Colors.green,

          //   ),

          // ),

          IconButton(

            onPressed: () {
              Widget okButton = MaterialButton(
                child: Text("نعم",textDirection: TextDirection.rtl,),
                onPressed:  () {
                  AppCubit.get(context).deleteData(

                    id: model['id'],);
                  Navigator.of(context).pop();
                },
                color: defaultColor,
                textColor: Colors.brown[100],

              );
              Widget cancelButton = MaterialButton(
                child: Text("لا ",textDirection: TextDirection.rtl,),
                onPressed:  () {
                  Navigator.of(context).pop();
                },
                 color: defaultColor,
              textColor: Colors.brown[50],
                textTheme: ButtonTextTheme.primary,
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                backgroundColor: Colors.brown[50],
                title: Text("  حذف " , textDirection: TextDirection.rtl,style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[400],
                ),),
                content: Text("هل تريد تأكيد الحذف ؟ ",textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.brown[500],
                  fontSize:17.0,
                    fontStyle: FontStyle.italic,
                ),),
                actions: [
                  okButton,
                  cancelButton,
                ],
                actionsAlignment: MainAxisAlignment.center,
              );

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

              color: Colors.brown[300],

            ),

          ),

        ],

      ),

    ),

    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },

  ),
  onTap: (){
   navigateTo(context, CounterScreen(
     num: model['num'].toString(),
   ));

  },
);



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
              size: 120.0,
              color: Colors.brown[400],
            ),
            Text(
              'لا يوجد تسابيح , برجاء اضافة البعض ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown[300],
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
    height: 1.3,
    color: Colors.brown[400],
  ),
);

// Widget buildArticleItem(article, context) => InkWell(
//   onTap: () {
//     navigateTo(
//       context,
//       WebViewScreen(article['url']),
//     );
//   },
//   child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         Container(
//           width: 120.0,
//           height: 120.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//               10.0,
//             ),
//             image: DecorationImage(
//               image: NetworkImage('${article['urlToImage']}'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Container(
//             height: 120.0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${article['title']}',
//                     style: Theme.of(context).textTheme.bodyText1,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Text(
//                   '${article['publishedAt']}',
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 15.0,
//         ),
//       ],
//     ),
//   ),
// );

// Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
//   condition: list.length > 0,
//   builder: (context) => ListView.separated(
//     physics: BouncingScrollPhysics(),
//     itemBuilder: (context, index) => buildArticleItem(list[index], context),
//     separatorBuilder: (context, index) => myDivider(),
//     itemCount: 10,
//   ),
//   fallback: (context) =>
//   isSearch ? Container() : Center(child: CircularProgressIndicator()),
// );

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

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

// Widget buildListProduct(
//     model,
//     context, {
//       bool isOldPrice = true,
//     }) =>
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         height: 120.0,
//         child: Row(
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 Image(
//                   image: NetworkImage(model.image),
//                   width: 120.0,
//                   height: 120.0,
//                 ),
//                 if (model.discount != 0 && isOldPrice)
//                   Container(
//                     color: Colors.red,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 5.0,
//                     ),
//                     child: Text(
//                       'DISCOUNT',
//                       style: TextStyle(
//                         fontSize: 8.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     model.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       height: 1.3,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         model.price.toString(),
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: defaultColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5.0,
//                       ),
//                       if (model.discount != 0 && isOldPrice)
//                         Text(
//                           model.oldPrice.toString(),
//                           style: TextStyle(
//                             fontSize: 10.0,
//                             color: Colors.grey,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context).changeFavorites(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15.0,
//                           backgroundColor:
//                           ShopCubit.get(context).favorites[model.id]!
//                               ? defaultColor
//                               : Colors.grey,
//                           child: Icon(
//                             Icons.favorite_border,
//                             size: 14.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
