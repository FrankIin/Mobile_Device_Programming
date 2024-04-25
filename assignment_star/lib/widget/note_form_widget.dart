import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NoteFormWidget extends StatelessWidget {
  final int? rating;
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? address;
  final String? description;
  final ValueChanged<int> onChangedRating;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedAddress;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.rating = 0,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.address = '',
    this.description = '',
    required this.onChangedRating,
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedAddress,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: (rating ?? 0).toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.green,
            ),
            onRatingUpdate: (rating) => onChangedRating(rating.toInt()),
          ),
        ],
      ),
          Row(
            children: [
              Switch(
                value: isImportant ?? false,
                onChanged: onChangedImportant,
              ),
              Expanded(
                child: Slider(
                  value: (number ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (number) => onChangedNumber(number.toInt()),
                ),
              )
            ],
          ),
          buildTitle(),
          buildAddress(),
          const SizedBox(height: 4),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),

  );



  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Restaurant name',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Restaurant name cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildAddress() => TextFormField(
    maxLines: 1,
    initialValue: address,
    style: const TextStyle(
      color: Colors.white30,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Address of Restaurant',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (address) =>
    address != null && address.isEmpty ? 'The Address of the restaurant cannot be empty' : null,
    onChanged: onChangedAddress,
  );


  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.white60, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type your dish...',
      hintStyle: TextStyle(color: Colors.white60),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description of the dish cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );
}