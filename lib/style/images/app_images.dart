class AppImages{
  static image(String name) => 'assets/images/$name.png';

  static get image1 => AppImages.image('image1');
  static get image2 => AppImages.image('image2');
  static get image3 => AppImages.image('image3');
}