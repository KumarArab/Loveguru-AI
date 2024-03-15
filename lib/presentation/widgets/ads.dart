import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const testHtml = """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Ad</title>
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5323141255263993"
    crossorigin="anonymous"></script>
</head>

<body>
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5323141255263993"
        crossorigin="anonymous"></script>
    <!-- banner-ad -->
    <ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-5323141255263993" data-ad-slot="6882720463"
        data-ad-format="auto" data-full-width-responsive="true"></ins>
    <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
    </script>
</body>
</html>

""";

class GoogleBannerAdSpaceWidget extends StatefulWidget {
  const GoogleBannerAdSpaceWidget({
    super.key,
  });

  @override
  State<GoogleBannerAdSpaceWidget> createState() => _GoogleBannerAdSpaceWidgetState();
}

class _GoogleBannerAdSpaceWidgetState extends State<GoogleBannerAdSpaceWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadHtmlString(testHtml);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      alignment: Alignment.center,
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
