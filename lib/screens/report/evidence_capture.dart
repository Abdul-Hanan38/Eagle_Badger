import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:eagle_badger/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class EvidenceCaptureScreen extends StatefulWidget {
  const EvidenceCaptureScreen({super.key});

  @override
  State<EvidenceCaptureScreen> createState() => _EvidenceCaptureScreenState();
}

class _EvidenceCaptureScreenState extends State<EvidenceCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  String _selectedMode = "Photo";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      try {
        await _controller!.initialize();
        if (mounted) setState(() => _isInitialized = true);
      } catch (e) {
        debugPrint("Camera error: $e");
      }
    }
  }

  @override
  void dispose() {
    if (_controller != null && _controller!.value.isInitialized) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Evidence Capture',
        onBackTap: () => Navigator.pop(context),
        actionText: 'Done',
        actionColor: Theme.of(context).colorScheme.primary,
        onActionTap: () =>
            Navigator.pushReplacementNamed(context, '/fieldWork'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: context.screenWidth * 0.85,
                        height: context.screenHeight * 0.4,
                        child: _isInitialized
                            ? CameraPreview(_controller!)
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 40,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 8,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "00:00:00",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ["Video", "Photo", "Panic"].map((mode) {
                bool isSelected = _selectedMode == mode;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMode = mode),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Text(
                          mode,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primaryFixed,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.circle,
                            size: 4,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _buildGpsOverlay(),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildGpsOverlay() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GPS & Timestamp Auto-logged",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "38.8977° N, 77.0365° W",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "UTC 2024-05-24 | 14:22:01.45",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: context.isSmall ? 20 : 25,
            backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
            child: Icon(
              Icons.photo_library,
              color: Theme.of(context).colorScheme.onSurface,
              size: context.isSmall ? 20 : 25,
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (_isInitialized && _controller != null) {
                await _controller!.takePicture();
                await Future.delayed(const Duration(milliseconds: 100));
                if (mounted) Navigator.pushNamed(context, '/resultSheet');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: context.isSmall ? 30 : 35,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: context.isSmall ? 25 : 30,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: context.isSmall ? 20 : 25,
              backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
              child: Icon(
                Icons.cached,
                color: Theme.of(context).colorScheme.onSurface,
                size: context.isSmall ? 20 : 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
