// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState extends Equatable {
  final File? frameFile;
  final File? backgroundFile;

  const MainState({
    this.frameFile,
    this.backgroundFile,

  });
  @override
  List<Object?> get props => [frameFile,backgroundFile];



  MainState copyWith({
    File? frameFile,
    File? backgroundFile,
  }) {
    return MainState(
      frameFile: frameFile ?? this.frameFile,
      backgroundFile: backgroundFile ?? this.backgroundFile,
    );
  }
}
