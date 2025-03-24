import 'package:stirred_app/router/app_router.dart';
import 'package:stirred_app/presentation_old/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

class GenericObjectPickerModal<T extends GenericDataModel> extends ConsumerStatefulWidget {
  final Future<List<T>> Function(String query, WidgetRef ref) searchFunction;
  final T? currentItem;
  final String title;

  const GenericObjectPickerModal({
    super.key,
    required this.searchFunction,
    this.title = "",
    this.currentItem,
  });

  @override
  ConsumerState<GenericObjectPickerModal<T>> createState() => _GenericObjectPickerModal();
}

class _GenericObjectPickerModal<T extends GenericDataModel> extends ConsumerState<GenericObjectPickerModal<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> searchResults = [];
  T? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.currentItem;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
            minHeight: 250,
            minWidth: 160,
            maxHeight: 384,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
              const SizedBox(height: 8,),
              CustomSearchBar(
                hintText: "Search",
                controller: _searchController,
                onChanged: (query) async {
                  List<T> res = await widget.searchFunction.call(query, ref);
                  setState(() {
                    searchResults = res;
                  });
                },
                width: 300,
                margin: const EdgeInsets.only(left: 4, right: 8),
              ),
              const SizedBox(height: 12,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...searchResultsWidgetList,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(const BorderSide(color: Colors.grey)),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16))
                    ),
                    onPressed: () {
                      appRouter.pop();
                    },
                    child: const Text("Cancel", style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),)
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(16))
                      ),
                    onPressed: () {
                      appRouter.pop(selectedItem);
                    },
                    child: const Text("Confirm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get searchResultsWidgetList {
    return searchResults.map((item) => GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: selectedItem == item ? Colors.deepPurpleAccent.withOpacity(0.2) : Colors.transparent
          ),
          child: Row(
            children: [
              Text(item.name ?? "",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4,),
              Text("(${item.id})",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    )).toList();
  }
}