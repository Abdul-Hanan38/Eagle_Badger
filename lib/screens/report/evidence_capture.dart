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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Evidence Capture",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Done",
              style: TextStyle(
                color: Color(0xFFC6102E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
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
                      width: 300,
                      height: 300,
                      child: _isInitialized
                          ? CameraPreview(_controller!)
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFC6102E),
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
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Colors.red, size: 8),
                          SizedBox(width: 5),
                          Text(
                            "00:00:00",
                            style: TextStyle(color: Colors.white, fontSize: 12),
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
                              ? const Color(0xFFC6102E)
                              : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.circle,
                          size: 4,
                          color: Color(0xFFC6102E),
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
    );
  }

  Widget _buildGpsOverlay() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on, color: Color(0xFFC6102E), size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GPS & Timestamp Auto-logged",
                  style: TextStyle(color: Color(0xFFC6102E), fontSize: 10),
                ),
                Text(
                  "38.8977° N, 77.0365° W",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "UTC 2024-05-24 | 14:22:01.45",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: Color(0xFFC6102E)),
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
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white10,
            child: Icon(Icons.photo_library, color: Colors.white),
          ),
          GestureDetector(
            onTap: () async {
              if (_isInitialized) {
                await _controller!.takePicture();
                if (mounted) {
                  Navigator.pushNamed(context, '/resultSheet');
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFC6102E),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
              ),
            ),
          ),
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white10,
            child: Icon(Icons.cached, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
