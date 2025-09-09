import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({super.key, required this.description});

  final String description;

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  final translator = GoogleTranslator();
  String? translatedText;
  bool showTranslated = false;
  bool isLoading = false;

  Future<void> translateText() async {
    if (translatedText != null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var translation = await translator.translate(widget.description, to: 'pt');
      setState(() {
        translatedText = translation.text;
      });
    } catch (e) {
      setState(() {
        translatedText = "Erro ao traduzir.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Text(
            (showTranslated && translatedText != null) ? translatedText! : widget.description,
            style: TextStyle(fontSize: 15),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    if (translatedText == null) {
                      await translateText();
                    }
                    setState(() {
                      showTranslated = !showTranslated;
                    });
                  },
                  child: Text(
                    showTranslated ? "EN-US" : "PT-BR",
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ],
    );
  }
}
