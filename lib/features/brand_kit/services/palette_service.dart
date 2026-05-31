import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

final paletteServiceProvider = Provider<PaletteService>((ref) {
  return const PaletteService();
});

class PaletteService {
  const PaletteService();

  List<BrandPalette> get presets => brandPalettePresets;
}

class BrandPalette {
  const BrandPalette({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
  });

  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
}

const brandPalettePresets = <BrandPalette>[
  BrandPalette(
    name: 'Gold Luxury',
    primary: AppColors.gold,
    secondary: AppColors.obsidian,
    accent: AppColors.goldLight,
  ),
  BrandPalette(
    name: 'Ocean',
    primary: Color(0xFF38BDF8),
    secondary: Color(0xFF082F49),
    accent: Color(0xFF67E8F9),
  ),
  BrandPalette(
    name: 'Sunset',
    primary: Color(0xFFF97316),
    secondary: Color(0xFF431407),
    accent: Color(0xFFFACC15),
  ),
  BrandPalette(
    name: 'Mono',
    primary: Color(0xFFE5E7EB),
    secondary: Color(0xFF111827),
    accent: Color(0xFF9CA3AF),
  ),
  BrandPalette(
    name: 'Pastel',
    primary: Color(0xFFF0ABFC),
    secondary: Color(0xFF312E81),
    accent: Color(0xFFA7F3D0),
  ),
  BrandPalette(
    name: 'Neon',
    primary: Color(0xFF22C55E),
    secondary: Color(0xFF020617),
    accent: Color(0xFFE879F9),
  ),
  BrandPalette(
    name: 'Earth',
    primary: Color(0xFFA3E635),
    secondary: Color(0xFF1C1917),
    accent: Color(0xFFF59E0B),
  ),
  BrandPalette(
    name: 'Cyber',
    primary: Color(0xFF60A5FA),
    secondary: Color(0xFF0F172A),
    accent: Color(0xFFF472B6),
  ),
];
