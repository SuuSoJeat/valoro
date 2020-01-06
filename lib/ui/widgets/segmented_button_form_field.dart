import 'package:flutter/material.dart';
import 'package:valoro/ui/widgets/segmented_button.dart';

class SegmentedButtonFormField extends FormField<String> {
  SegmentedButtonFormField({
    Map<BadgeOption, bool> options,
    BadgeOption defaultOption,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<String> fieldState) {
            return SegmentedButton(
              options: options,
              defaultOption: defaultOption,
              onValueChanged: (option) {
                fieldState.didChange(option.toString().split('.')[1]);
              },
            );
          },
        );
}
