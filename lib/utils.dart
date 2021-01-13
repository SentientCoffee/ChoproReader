import "package:flutter/material.dart";

class Utils {
  static Widget buildErrorPage(String className, String funcName, String errorMsg) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "[$className:$funcName]",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: "Monospace",
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "ERROR::$errorMsg",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontFamily: "Monospace",
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSpace({double height = 8.0}) {
    return Container(
      height: height,
      child: FlatButton(
        child: null,
        onPressed: null,
      ),
    );
  }
}
