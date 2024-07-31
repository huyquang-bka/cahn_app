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
    if (camera is Camera)
    {
      currentCamera = camera;
      _initPlayer();
      print("change camera: ${currentCamera.toJson()}");
      widget.changeNumCamera(widget.index, currentCamera.id ?? 0);
      if (currentCamera.rtspLink != null)
      {
        player.dispose();
      }
    }
  }
  
  @override
  void initState() {
    super.initState();
    setupCamera();
    DartVLC.initialize();
    player = Player(id: widget.index);
    if (currentCamera.rtspLink != null)
    {
      _initPlayer();
    }
  }

  void setupCamera() {
    if (widget.cameraId != null)
    {
      currentCamera = widget.cameras.firstWhere((element) => element.id == widget.cameraId);
    }
  }

  void _initPlayer() {
    print("init player: ${currentCamera.rtspLink}");
    setState(() {
      player = Player(id: widget.index);
      player.open(Media.network(currentCamera.rtspLink));
    });
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
      // width: double.infinity,
      // height: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          //title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropDownFilter(title: "Camera", items: widget.cameras, reset: false, onChanged: onChangeCamera, isExpanded: false),
            ],
          ),
          const SizedBox(height: defaultPadding),
          //camera view
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: onContainerColor),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: PlayerWidget(player: player),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          //button control
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //button play
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, color: onContainerColor),
              ),
              // button stop
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.stop, color: onContainerColor),
              ),
              // button reload
              IconButton(
                onPressed: () {},
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