import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lensai/features/geckoview/domain/entities/browser_icon.dart';

part 'web_page_info.g.dart';

@CopyWith()
class WebPageInfo {
  final Uri url;
  final String? title;
  final BrowserIcon? favicon;

  bool get isPageInfoComplete =>
      (title?.isNotEmpty ?? false) && favicon != null;

  WebPageInfo({
    required this.url,
    this.title,
    this.favicon,
  });
}
