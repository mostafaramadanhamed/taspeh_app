abstract class CounterStates {}
class CounterInitialState extends CounterStates{}
class CounterZeroState extends CounterStates{
  final int counter ;

  CounterZeroState(this.counter);

}
class CounterPlusState extends CounterStates{
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates{
  final int counter;

  CounterMinusState(this.counter);
}