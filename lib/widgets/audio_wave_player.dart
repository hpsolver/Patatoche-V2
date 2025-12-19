import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:path_provider/path_provider.dart';

class AudioWavePlayer extends StatefulWidget {
  final String assetPath;
  final VoidCallback? onDeleteTap;

  const AudioWavePlayer({super.key, required this.assetPath, this.onDeleteTap});

  @override
  State<AudioWavePlayer> createState() => _AudioWavePlayerState();
}

class _AudioWavePlayerState extends State<AudioWavePlayer> {
  late final PlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PlayerController();
    _prepare();
  }

  Future<void> _prepare() async {
    final filePath = await _copyAssetToLocal(widget.assetPath);

    await _controller.preparePlayer(
      path: filePath,
      shouldExtractWaveform: true,
      noOfSamples: 120,
    );
  }

  Future<String> _copyAssetToLocal(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;
  }

  void _togglePlay() async {
    if (_controller.playerState.isPlaying) {
      await _controller.pausePlayer();
    } else {
      await _controller.startPlayer();
    }
    setState(() {});
  }

  String _format(int ms) {
    final d = Duration(milliseconds: ms);
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes)}:${two(d.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorConstants.colorBBBBBB, width: 1.w),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 31.w,
              height: 31.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                _controller.playerState.isPlaying
                    ? Icons.pause_outlined
                    : Icons.play_arrow_outlined,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AudioFileWaveforms(
                    playerController: _controller,
                    size: const Size(double.infinity, 40),
                    enableSeekGesture: true,
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor: ColorConstants.colorBBBBBB,
                      liveWaveColor: Theme.of(context).primaryColor,
                      spacing: 5,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                StreamBuilder<int>(
                  stream: _controller.onCurrentDurationChanged,
                  builder: (context, snapshot) {
                    final current = snapshot.data ?? 0;
                    final total = _controller.maxDuration;
                    return Text(
                      /* "${_format(current)} / ${_format(total)}",*/
                      _format(current),
                    ).medium(
                      fontSize: 12.sp,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),

                Visibility(
                  visible: widget.onDeleteTap != null,
                  child: GestureDetector(
                    onTap: widget.onDeleteTap,
                    child: Container(
                      padding: EdgeInsets.only(left: 16.w),
                      child: ImageView(path: AssetsResource.icDelete3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
