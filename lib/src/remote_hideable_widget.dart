import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// A widget that hides or shows its [child] based on a boolean field in a Firestore document.
class RemoteHideable extends StatelessWidget {
  /// The widget to display if the condition is met (field is true).
  final Widget child;

  /// The Firestore collection name.
  final String collection;

  /// The Firestore document ID.
  final String document;

  /// The field name in the document to check (must be boolean).
  final String field;

  /// The value to use while loading or if an error occurs.
  /// Defaults to `false` (hidden).
  final bool initialValue;

  /// Optional widget to show when hidden (defaults to [SizedBox.shrink]).
  final Widget? placeholder;

  /// Optional Firestore instance for testing.
  final FirebaseFirestore? firestoreInstance;

  const RemoteHideable({
    super.key,
    required this.child,
    required this.collection,
    required this.document,
    required this.field,
    this.initialValue = false,
    this.placeholder,
    this.firestoreInstance,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: (firestoreInstance ?? FirebaseFirestore.instance)
          .collection(collection)
          .doc(document)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint('RemoteHideable Error: ${snapshot.error}');
          return _buildBasedOnValue(initialValue);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildBasedOnValue(initialValue);
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildBasedOnValue(initialValue);
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;
        final isVisible = data?[field] as bool? ?? initialValue;

        return _buildBasedOnValue(isVisible);
      },
    );
  }

  Widget _buildBasedOnValue(bool isVisible) {
    if (isVisible) {
      return child;
    } else {
      return placeholder ?? const SizedBox.shrink();
    }
  }
}
