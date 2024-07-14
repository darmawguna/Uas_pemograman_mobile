
class BasemapOption {
  final String name;
  final String urlTemplate;
  final String image;

  BasemapOption({
    required this.name,
    required this.urlTemplate,
    required this.image, // Initialize image with null by default
  });
}
