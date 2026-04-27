import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ResultSheetUploadScreen extends StatefulWidget {
  const ResultSheetUploadScreen({super.key});

  @override
  State<ResultSheetUploadScreen> createState() =>
      _ResultSheetUploadScreenState();
}

class _ResultSheetUploadScreenState extends State<ResultSheetUploadScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );
      try {
        await _controller!.initialize();
        if (mounted) setState(() => _isInitialized = true);
      } catch (e) {
        debugPrint("Camera Error: $e");
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
      bottomNavigationBar: _buildBottomNavMirror(),
      body: Stack(
        children: [
          Positioned.fill(
            child: _isInitialized
                ? CameraPreview(_controller!)
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.4)),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const Spacer(),
                _buildScanningFrame(),
                const SizedBox(height: 20),
                const Text(
                  "Hold steady...",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const Spacer(),
                _buildCaptureButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Result Sheet Upload",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Form EC8A", style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildScanningFrame() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Scanning Mode Active",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    return Padding(
      padding: context.isSmall
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () async {
          if (_isInitialized && _controller != null) {
            await _controller!.takePicture();
            await Future.delayed(const Duration(milliseconds: 100));
            if (mounted) Navigator.pushNamed(context, '/resultVerification');
          }
        },
        child: Container(
          width: context.isSmall ? 65 : 85,
          height: context.isSmall ? 65 : 85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 4,
            ),
          ),
          child: Center(
            child: CircleAvatar(
              radius: context.isSmall ? 25 : 32,
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              child: Icon(Icons.camera_alt, color: Colors.black, size: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavMirror() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
        color: Theme.of(context).colorScheme.surface,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavIcon(Icons.home, "Home"),
            _NavIcon(Icons.cloud_upload, "Upload", isActive: true),
            _NavIcon(Icons.assignment, "Reports"),
            _NavIcon(Icons.person, "Profile"),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavIcon(this.icon, this.label, {this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFFC6102E) : Colors.grey,
          size: 22,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFFC6102E) : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
