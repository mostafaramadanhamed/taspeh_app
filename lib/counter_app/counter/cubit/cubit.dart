
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit():super(CounterInitialState());
static CounterCubit get(context)=>BlocProvider.of(context);
int counter=0;
int pl=0;
void zero(){
  counter=0;
  emit(CounterZeroState(counter));
}
void plus(){

  counter++;

  emit(CounterPlusState(counter));
}void minus(){
  if(counter >0) {
    counter--;
  }else {
    counter=0;
  }
    emit(CounterMinusState(counter));
  }
void follow(){
  if(state is CounterPlusState){
    pl++;
  }
}


}