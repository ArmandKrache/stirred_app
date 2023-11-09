import 'package:stirred_common_domain/stirred_common_domain.dart';

String preprocessPictureUrl(String pictureUrl, String baseUrl) {
  if (pictureUrl.startsWith(baseUrl)) {
    return pictureUrl;
  } else {
    return baseUrl + pictureUrl;
  }
}




