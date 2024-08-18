import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final TextEditingController dateController;
  final bool enableValidation;
  final DateTime? initialDate;

  const DatePickerWidget({
    super.key,
    required this.dateController,
    this.enableValidation = true,
    this.initialDate,
  });

  @override
  DatePickerWidgetState createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {
  Future<void> _selectDate(BuildContext context) async {
    final firstDate = widget.initialDate != null &&
            widget.initialDate!.isBefore(DateTime.now())
        ? widget.initialDate!
        : DateTime.now();

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate =
          DateFormat("EEE, dd MMM yyyy", "pt_BR").format(selectedDate);
      widget.dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      decoration: const InputDecoration(
        labelText: 'Selecione a Data',
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: widget.enableValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma data';
              }
              return null;
            }
          : null,
    );
  }
}
