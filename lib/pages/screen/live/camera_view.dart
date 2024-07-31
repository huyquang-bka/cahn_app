import 'package:cahn_app/components/drop_down_filter.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key, required this.index, this.cameraId, required this.areas, required this.cameras, required this.changeNumCamera});
  final int index;
  final int? cameraId;
  final List<Area> areas;
  final List<Camera> cameras;
  final Function(int, int) changeNumCamera;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late Player player;
  Camera currentCamera = Camera();

  void onChangeCamera(dynamic camera) {
    if (camera is Camera) {
      setState(() {
        currentCamera = camera;
        _initPlayer();
        print("change camera: ${currentCamera.toJson()}");
        widget.changeNumCamera(widget.index, currentCamera.id ?? 0);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DartVLC.initialize();
    player = Player(id: widget.index);
    setupCamera();
      _initPlayer();
  }

  void setupCamera() {
    if (widget.cameraId != null) {
      currentCamera = widget.cameras.firstWhere((element) => element.id == widget.cameraId, orElse: () => Camera());
    }
  }

  void _initPlayer() {
    if (currentCamera.rtspLink != null) {
      player.open(Media.network(currentCamera.rtspLink!), autoStart: true);
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropDownFilter(
                title: "Camera",
                items: widget.cameras,
                reset: false,
                onChanged: onChangeCamera,
                isExpanded: false,
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          // camera view
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: onContainerColor),
              ),
              child: PlayerWidget(player: player),
            ),
          ),
          const SizedBox(height: defaultPadding),
          // button control
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // button play
              IconButton(
                onPressed: () => player.play(),
                icon: const Icon(Icons.play_arrow, color: onContainerColor),
              ),
              // button stop
              IconButton(
                onPressed: () => player.stop(),
                icon: const Icon(Icons.stop, color: onContainerColor),
              ),
              // button reload
              IconButton(
                onPressed: () => _initPlayer(),
                icon: const Icon(Icons.refresh, color: onContainerColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }
}
