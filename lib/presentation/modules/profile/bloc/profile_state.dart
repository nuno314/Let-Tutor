part of 'profile_bloc.dart';

class _ViewModel {
  final User? user;
  const _ViewModel({
    this.user,
  });

  _ViewModel copyWith({
    User? user,
  }) {
    return _ViewModel(
      user: user ?? this.user,
    );
  }
}

abstract class ProfileState {
  final _ViewModel viewModel;

  ProfileState(this.viewModel);

  T copyWith<T extends ProfileState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ProfileState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  User? get user => viewModel.user;
}

class ProfileInitial extends ProfileState {
  ProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class UpdateProfileSuccess extends ProfileState {
  UpdateProfileSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ProfileInitial: (viewModel) => ProfileInitial(
        viewModel: viewModel,
      ),
  UpdateProfileSuccess: (viewModel) => UpdateProfileSuccess(
        viewModel: viewModel,
      ),
};
