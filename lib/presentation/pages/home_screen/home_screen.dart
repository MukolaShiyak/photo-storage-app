import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/routes.dart';
import '/injector.dart';
import '/services/Ifile_picker_service.dart';
import '/presentation/bloc/profile_state.dart';
import '/data/datasource/photo_upload_api.dart';
import '/presentation/shared_widgets/app_bar.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';
import '/presentation/shared_widgets/page_layout.dart';
import '/presentation/pages/home_screen/progress_indicator.dart';
import '/presentation/bloc/photo_storage_bloc/photo_storage_bloc.dart';
import '/presentation/bloc/photo_storage_bloc/photo_storage_event.dart';
import '/presentation/bloc/photo_storage_bloc/photo_storage_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int imageLenght = 0;
  late StreamProgressIndicator _progressStream;

  final storage = locator.get<FlutterSecureStorage>();
  final _filePickerService = locator.get<IFilePickerService>();

  void _clearImageCount() => setState(() => imageLenght = 0);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: AppBarWidget(
        title: 'Home Screen',
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(const OnLogOut()),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, ProfileState>(
            listener: (context, state) {
              if (state.profile == null ||
                  (state.profile?.email != null &&
                      state.profile!.email.isEmpty)) {
                Navigator.of(context).pushReplacementNamed(Routes.signIn);
              }
            },
          ),
          BlocListener<PhotoStorageBloc, PhotoStorageState>(
            listener: (context, state) {
              if (state.status == PhotoStorageStatus.failure ||
                  state.status == PhotoStorageStatus.success) {
                setState(() {
                  _progressStream.counterStream.close();
                });
              }
            },
          ),
        ],
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await _filePickerService.pickMultiFiles();

                      if (result != null) {
                        imageLenght = result.files.length;

                        _progressStream = StreamProgressIndicator();

                        if (context.mounted) {
                          context.read<PhotoStorageBloc>().add(OnUploadPhotos(
                                photos: result,
                                streamProgress: _progressStream,
                                clearImageCount: _clearImageCount,
                              ));
                        }
                      }

                      setState(() {});
                    },
                    child: const Text('gallery'),
                  ),
                  Text(
                    'photos: $imageLenght',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  BlocBuilder<PhotoStorageBloc, PhotoStorageState>(
                    builder: (context, state) {
                      if (state.status == PhotoStorageStatus.loading) {
                        return UploadProgressIndicator(
                            progressStream: _progressStream);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
