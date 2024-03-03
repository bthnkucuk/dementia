// ignore_for_file: constant_identifier_names

enum FlavorType { DEVELOPMENT, PRODUCTION, STAGING }

class FlavorModel {
  final FlavorType flavorType;
  final String name;

  const FlavorModel({
    required this.flavorType,
    required this.name,
  });
}
