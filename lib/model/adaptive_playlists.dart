import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:hello_mdfk/page/playlist_details.dart';
import 'package:split_view/split_view.dart';

import 'playlists.dart';

// official sample https://codelabs.developers.google.com/codelabs/flutter-adaptive-app?hl=zh-cn#3
class AdaptivePlaylists extends StatelessWidget {
  const AdaptivePlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetPlatform = Theme.of(context).platform;
    // 判斷平台
    if (targetPlatform == TargetPlatform.android ||
        targetPlatform == TargetPlatform.iOS ||
        screenWidth <= 600) {
      return const NarrowDisplayPlaylists();
    } else {
      return const WideDisplayPlaylists();
    }
  }
}

class NarrowDisplayPlaylists extends StatelessWidget {
  const NarrowDisplayPlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FlutterDev Playlists')),
      body: Playlists(
        playlistSelected: (playlist) {
          context.go(
            Uri(
              path: '/playlist/${playlist.id}',
              queryParameters: <String, String>{
                'title': playlist.snippet!.title!
              },
            ).toString(),
          );
        },
      ),
    );
  }
}

class WideDisplayPlaylists extends StatefulWidget {
  const WideDisplayPlaylists({super.key});

  @override
  State<WideDisplayPlaylists> createState() => _WideDisplayPlaylistsState();
}

class _WideDisplayPlaylistsState extends State<WideDisplayPlaylists> {
  Playlist? selectedPlaylist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 動態調整 AppBar 顯示字串
        title: selectedPlaylist == null
            ? const Text('FlutterDev Playlists')
            : Text('FlutterDev Playlist: ${selectedPlaylist!.snippet!.title!}'),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        children: [
          Playlists(playlistSelected: (playlist) {
            setState(() {
              selectedPlaylist = playlist;
            });
          }),
          if (selectedPlaylist != null)
            PlaylistDetails(
                playlistId: selectedPlaylist!.id!,
                playlistName: selectedPlaylist!.snippet!.title!)
          else
            const Center(
              child: Text('Select a playlist'),
            ),
        ],
      ),
    );
  }
}
