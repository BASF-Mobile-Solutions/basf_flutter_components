import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  final String? showText;
  final bool? dependency;

  const LoadingAnimation({
    Key? key,
    this.showText = '',
    this.dependency = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: dependency!,
      child: Container(
        color: BasfColors.black.withOpacity(0.2),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2,
          alignment: Alignment.center,
          color: BasfColors.copyTextGrey.withOpacity(0.6),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (showText!.isNotEmpty) const SizedBox(height: 50),
              if (showText!.isNotEmpty)
                FittedBox(
                  child: Text(
                    showText!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: BasfColors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
