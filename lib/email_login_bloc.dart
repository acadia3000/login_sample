import 'package:rxdart/rxdart.dart';
import 'package:login_sample/validator.dart';

class EmailLoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get loginCheck =>
      Observable.combineLatest2(email, password, (e, p) => true);

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
