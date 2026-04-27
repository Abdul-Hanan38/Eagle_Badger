import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'field_report_screen.dart';

class PosterReportScreen extends StatefulWidget {
  const PosterReportScreen({super.key});

  @override
  State<PosterReportScreen> createState() => _PosterReportScreenState();
}

class _PosterReportScreenState extends State<PosterReportScreen> {
  CameraController? _controller;
  String _selectedDensity = "Medium";

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Poster Report',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            RepaintBoundary(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                height: context.screenHeight * 0.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      (_controller != null && _controller!.value.isInitialized)
                      ? CameraPreview(_controller!)
                      : Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                ),
              ),
            ),
            Text(
              "Select Density",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 15),
            _buildDensityBar(),
            const Spacer(),
            _buildCameraControls(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDensityBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryFixedDim,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: ["Low", "Medium", "High"].map((level) {
          bool isSel = _selectedDensity == level;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedDensity = level),
              child: Container(
                padding: context.isSmall
                    ? EdgeInsets.symmetric(vertical: 5)
                    : EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSel
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      level == "Low"
                          ? Icons.person
                          : level == "Medium"
                          ? Icons.group
                          : Icons.groups,
                      color: isSel
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onPrimary,
                      size: context.isSmall ? 15 : 20,
                    ),
                    Text(
                      level,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSel
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCameraControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.grid_on,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await _controller?.pausePreview();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FieldReportScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: context.isSmall ? EdgeInsets.all(8) : EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sync,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
