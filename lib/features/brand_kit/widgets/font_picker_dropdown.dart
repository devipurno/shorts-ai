import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/logger.dart';

const curatedBrandFonts = <String>[
  'Inter',
  'Poppins',
  'Montserrat',
  'Oswald',
  'Bebas Neue',
  'Anton',
  'Roboto',
  'Playfair Display',
  'Lato',
  'JetBrains Mono',
];

class FontPickerDropdown extends StatelessWidget {
  const FontPickerDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue:
          curatedBrandFonts.contains(value) ? value : curatedBrandFonts.first,
      dropdownColor: AppColors.surface2,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final font in curatedBrandFonts)
          DropdownMenuItem(
            value: font,
            child: Text(
              '$font  Aa Bb 123',
              style: _fontStyle(font),
            ),
          ),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

TextStyle _fontStyle(String font) {
  if (font == 'JetBrains Mono') {
    return GoogleFonts.jetBrainsMono(
      color: AppColors.textPrimary,
      fontSize: 14,
    );
  }

  try {
    return GoogleFonts.getFont(
      font,
      color: AppColors.textPrimary,
      fontSize: 14,
    );
  } catch (error, stackTrace) {
    AppLogger.w(
      'Google Font "$font" unavailable, using fallback',
      tag: 'FontPicker',
      error: error,
      stackTrace: stackTrace,
    );
    return AppTypography.bodyMedium;
  }
}
