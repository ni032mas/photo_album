import 'package:flutter/material.dart' hide showMenu;
import 'package:flutter/material.dart' as material show showMenu;

mixin CustomPopupMenu<T extends StatefulWidget> on State<T> {
  Offset _tapPosition;

  void storePosition(TapDownDetails details) => _tapPosition = details.globalPosition;

  Future<T> showMenu<T>({
    @required BuildContext context,
    @required List<PopupMenuEntry<T>> items,
    T initialValue,
    double elevation,
    String semanticLabel,
    ShapeBorder shape,
    Color color,
    bool useRootNavigator = false,
  }) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    return material.showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapPosition.dx,
        _tapPosition.dy,
        overlay.size.width - _tapPosition.dx,
        overlay.size.height - _tapPosition.dy,
      ),
      items: items,
      initialValue: initialValue,
      elevation: elevation,
      semanticLabel: semanticLabel,
      shape: shape,
      color: color,
      useRootNavigator: useRootNavigator,
    );
  }
}
