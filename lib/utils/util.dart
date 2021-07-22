import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListBoolNotifier extends StateNotifier<List<bool>> {
  ListBoolNotifier(state) : super(state);
  void toggle(index) {
    state = [
      for (int i = 0; i < state.length; i++) i == index ? !state[i] : state[i]
    ];
  }

  void setAllto(bool target) {
    state = [for (int i = 0; i < state.length; i++) target];
  }
}
