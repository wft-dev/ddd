import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/todo.dart';
part 'todo_controller.g.dart';

// This will generates a Notifier and NotifierProvider.
// The Notifier class that will be passed to our NotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using todosProvider(NotifierProvider) to allow the UI to
// interact with our Todos class.

@riverpod
class TodoController extends _$TodoController {
  @override
  FutureOr<List<Todo>> build() async {
    return [];
  }

  // Let's allow the UI to add todos.
  Future<void> addTodo(Todo todo) async {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = const AsyncValue.loading();
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  Future<void> removeTodo(String todoId) async {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = const AsyncValue.loading();
  }

  // Let's mark a todo as completed
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
  }
}
