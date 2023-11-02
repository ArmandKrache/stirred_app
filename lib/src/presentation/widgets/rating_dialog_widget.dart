import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/widgets/custom_text_tile.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

class RatingDialogWidget extends StatefulWidget {
  final String drinkId;
  final Rating? currentRating;
  final Function(RatingCreateRequest request) createRatingFunction;
  final Function(RatingPatchRequest request) patchRatingFunction;

  const RatingDialogWidget({
    super.key,
    required this.drinkId,
    required this.createRatingFunction,
    required this.patchRatingFunction,
    this.currentRating,
  });


  @override
  State<RatingDialogWidget> createState() => _RatingDialogWidgetState();
}

class _RatingDialogWidgetState extends State<RatingDialogWidget> {
  int rating = 0;
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentController.text = widget.currentRating?.comment ?? "";
    rating = widget.currentRating?.rating ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text("Rate this recipe",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const Expanded(child: SizedBox(width: 4,)),
                  RatingBarIndicator(
                    rating: rating.toDouble(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          rating = (index + 1).toInt();
                        });
                      },
                      child: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    itemCount: 5,
                    itemSize: 32.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: commentController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Comment",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (rating != 0) {
                          if (widget.currentRating == null) {
                            await widget.createRatingFunction.call(RatingCreateRequest(
                              drinkId: widget.drinkId,
                              comment: commentController.text,
                              rating: rating.toInt()
                            ));
                          } else {
                            await widget.patchRatingFunction.call(RatingPatchRequest(
                              id: widget.currentRating!.id,
                              body: {
                                "comment" : commentController.text,
                                "rating": rating.toInt()
                              }
                            ));
                          }
                          appRouter.pop();
                        }
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(rating != 0 ? Colors.green : Colors.grey)),
                      child: const Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        )
    );
  }

}