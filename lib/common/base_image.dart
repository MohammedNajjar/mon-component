import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/web_service/constants.dart';

class MBImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final Color? color;

  final Widget? placeholder;

  static String get id {
    const Type type = MBImage;
    return '$type';
  }

  const MBImage(this.url,
      {this.width,
      this.height,
      this.radius,
      this.fit,
      this.placeholder,
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null && url?.startsWith("assets") == true) {
      final image = url?.endsWith(".svg") == true
          ? SvgPicture.asset(
              url!,
              width: width,
              height: height,
              fit: fit ?? BoxFit.fill,
            )
          : Image.asset(
              url!,
              width: width,
              height: height,
              fit: fit ?? BoxFit.fill,
            );
      final coloredImage = color != null ? ColorFiltered(
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        child: image ) : image;
      return radius != null
          ? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
              child: coloredImage,
            )
          : coloredImage;
    }

    final placeholderImage = placeholder ??
        SvgPicture.asset("general/ic_empty_state.svg".image_);
    if(url != null && url?.endsWith(".svg") == true) {
      // Logger.log("url => $url ${url?.endsWith(".svg")}");
      return CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(
                child: CircularProgressIndicator(
                    value: downloadProgress.progress)),
        errorWidget: (context, url, error) => SvgPicture.network(
          url!,
          width: width,
          height: height,
        ),
        imageBuilder: (context, imageProvider) => SvgPicture.network(
          url!,
          width: width,
          height: height,
        )
      );
    }
    final image = url != null
        ? CachedNetworkImage(
            imageUrl: url ?? Constants.apiUrl,
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => placeholderImage,
            // (placeholder ?? const Icon(Icons.error)),
          )
        : placeholderImage;
    return radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(radius!)),
            child: image,
          )
        : image;
  }
}
