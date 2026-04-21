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
    _controller?.dispose();
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
                : const Center(
                    child: CircularProgressIndicator(color: Color(0xFFC6102E)),
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
                  style: TextStyle(color: Colors.white70),
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
            child: const CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Text(
                  "Result Sheet Upload",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Form EC8A",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
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
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC6102E), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFC6102E).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "Scanning Mode Active",
            style: TextStyle(
              color: Color(0xFFC6102E),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () async {
          if (_isInitialized) {
            await _controller!.takePicture();
            debugPrint("Document Clicked");
          }
        },
        child: Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFC6102E), width: 4),
          ),
          child: const Center(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, color: Colors.black, size: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavMirror() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Theme.of(context).colorScheme.onSecondary,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(Icons.home, "Home"),
          _NavIcon(Icons.cloud_upload, "Upload", isActive: true),
          _NavIcon(Icons.assignment, "Reports"),
          _NavIcon(Icons.person, "Profile"),
        ],
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
