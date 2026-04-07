// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_todo/BaseHttp.dart' as _i1023;
import 'package:online_todo/modules/home/services/notes.service.dart' as _i886;
import 'package:online_todo/modules/login/services/login.service.dart' as _i259;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1023.Basehttp>(() => _i1023.Basehttp());
    gh.lazySingleton<_i886.NotesService>(
      () => _i886.NotesService(gh<_i1023.Basehttp>()),
    );
    gh.lazySingleton<_i259.LoginService>(
      () => _i259.LoginService(gh<_i1023.Basehttp>()),
    );
    return this;
  }
}
