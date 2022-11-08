import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:tutorial/counter_app/counter/cubit/cubit.dart';
import 'package:tutorial/counter_app/counter/cubit/states.dart';
import 'package:tutorial/homeScreen.dart';
import 'package:tutorial/shared/cubit/cubit.dart';
import 'package:tutorial/shared/styeles/color.dart';
class CounterScreen extends StatefulWidget {
  final String num;


  CounterScreen({

    required this.num,
  });

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int da=0;

  @override
  Widget build(BuildContext context) {
  return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates> (
        listener: (context,state){
          if(state is CounterZeroState) {
            print('minus state ${state.counter}');
          }
          if(state is CounterPlusState) {
            print('plus state ${state.counter}');
          }
        },
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: Colors.brown[50],
            ),
            body: Column(
              children: [
                const SizedBox(
                  width: 350,
                  height: 60.0,
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.only(
                    end: 15.0,
                    start: 15.0,
                    top: 15.0,
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                             Text(
                                'الدورة  ',
                              textAlign: TextAlign.end,
                              style:Theme.of(context).textTheme.headline5!.copyWith(
                                color: Colors.brown[600]
                              )
                      ),
                            Spacer(),
                            Text(
                              'العدد الكلي ',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                  color: Colors.brown[600]
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 25.0,
                            ),
                            Text(
                              '${da}',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 20.0,
                                color:Colors.brown[300]
                              ),
                            ),

                            Spacer(),
                            Text(
                              '${CounterCubit.get(context).pl  }',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 20.0,
                                  color:Colors.brown[300]

                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                     InkWell(
                       onTap: (){
                         if(int.parse(widget.num)> CounterCubit.get(context).counter ){
                         CounterCubit.get(context).plus();
                         CounterCubit.get(context).follow();

                         }
                          else if(int.parse(widget.num) ==CounterCubit.get(context).counter){
                           setState((){
                             da++;
                           });
                            CounterCubit.get(context).counter=1;
                            CounterCubit.get(context).follow();
                         }
                       },
                       child: Container(
                         height: 200,
                         width: 350,
                         color: Colors.brown[50],
                         child:
                            CircleAvatar(
                              radius: 100.0,
                              backgroundColor: Colors.brown[500],

                              child: CircleAvatar(
                               radius: 96.0,
                               backgroundColor: Colors.brown[100],
                               child: Padding(
                                 padding: const EdgeInsets.all(20.0),
                                 child: Text(
                                   '${CounterCubit.get(context).counter}',
                                   style:  TextStyle(
                                     fontSize: 35.0,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.brown[600],
                                   ),
                                 ),
                               ),
                               ),
                            ),

                       ),
                     ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          CounterCubit.get(context).zero();
                          CounterCubit.get(context).pl=0;
                          da=0;
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.brown[100],
                          radius: 27.0,
                          child: const Text('0',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: Colors.brown,
                            ),),

                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          CounterCubit.get(context).minus();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.brown[100],
                          radius: 27.0,
                            child:const Text('-',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                color: Colors.brown,
                              ),),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
