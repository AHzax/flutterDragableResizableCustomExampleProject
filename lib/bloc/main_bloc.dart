import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<PickBackgroundImageEvent>(_onPickBackgroundImage);
    on<PickFrameImageEvent>(_onPickFrameImage);

  }

  _onPickBackgroundImage(
      PickBackgroundImageEvent event, Emitter<MainState> emit) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    final image = File(file.path);
    emit(state.copyWith(backgroundFile: image));
  }

_onPickFrameImage(PickFrameImageEvent event, Emitter<MainState> emit) async{
  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    final image = File(file.path);
    emit(state.copyWith(frameFile: image));
  }
}
