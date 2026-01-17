# Remote Widget Hideable

[![Pub Version](https://img.shields.io/pub/v/remote_widget_hideable)](https://pub.dev/packages/remote_widget_hideable)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple Flutter widget to show or hide UI components remotely using Cloud Firestore.
Useful for feature flagging, hiding components during app review, or A/B testing.

**Repository:** [https://github.com/kedirinesia/remote-hideable-widget-](https://github.com/kedirinesia/remote-hideable-widget-)

## Features

- **Real-time Updates**: Listens to Firestore document changes.
- **Null Safety**: Robust error handling and default values.
- **Custom placeholders**: Show a specific widget (or nothing) when hidden.

## Installation

Add dependencies to `pubspec.yaml`:

```yaml
dependencies:
  cloud_firestore: latest_version
  remote_widget_hideable:
    path: ./ # or git path
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:remote_widget_hideable/remote_widget_hideable.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RemoteHideable(
          collection: 'app_config',
          document: 'checkout_settings',
          field: 'enable_promo_banner',
          initialValue: false, // Default while loading
          placeholder: Text('Promo is currently disabled'), // Optional
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(20),
            child: Text(' BIG PROMO! '),
          ),
        ),
      ),
    );
  }
}
```

## Firestore Structure

Ensure you have a document in Firestore matching the path:

- **Collection**: `app_config`
- **Document**: `checkout_settings`
- **Field**: `enable_promo_banner` (boolean)

If `true`, the child widget is shown. If `false`, it's hidden.

## Configuration Example

A `.env.example` file is included in the package root to help you structure your environment variables if needed:

```dotenv
# Firestore Remote Config Example
REMOTE_COLLECTION=app_config
REMOTE_DOCUMENT=global_settings
REMOTE_FIELD=enable_feature_x
```
