import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial()) {
    var userData;
    bool isLoading = false;
    on<PersonalEvent>((event, emit) async {
      if (event is PersonalLoad) {
        userData = await ApiClient.get('api/v1/users/profile/details/');

        emit(PersonalLoaded(data: userData, isLoading: isLoading));
      }
      if (event is PersonalChange) {
        isLoading = true;
        emit(PersonalLoaded(data: userData, isLoading: isLoading));
        Map<String, dynamic> data = {};
        if (event.email != userData['email']) {
          data['email'] = event.email;
        }
        if (event.username != userData['username']) {
          data['username'] = event.username;
        }
        if (event.currentPassword != '') {
          data['password'] = event.currentPassword;
        }
        if (event.newPassword != '' && event.repeatPassword != '') {
          data['new_password'] = event.newPassword;
          data['new_password_confirm'] = event.repeatPassword;
        }

        var response = await ApiClient.patch(
          'api/v1/users/profile/details/update/',
          data,
        );
        if (response == true) {
          emit(PersonalSuccess(message: 'Successfully changed!'));
        } else {
          if (response.containsKey('title')) {
            emit(PersonalError(message: response['title']));
          } else {
            emit(PersonalError(message: 'Error!'));
          }
        }
        isLoading = false;
        emit(PersonalLoaded(data: userData, isLoading: isLoading));
        add(PersonalLoad());
      }
    });
  }
}
// {
//     "username": "ddd",
//     "email": "muxammederaliev@gmail.com",
//     "commission": null,
//     "is_active": true,
//     "first_name": null,
//     "last_name": null,
//     "is_email_verified": true
// }