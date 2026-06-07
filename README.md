# Fishing Lure Picker

## What the App Does

This Flutter app recommends a fishing lure and lure color based on the selected water clarity and time of day. The user selects both options and presses **Recommend Lure** to see the result.

## How to Run

```bash
flutter pub get
flutter run
```

## Color Palette

The app cycles through 5 colors when the user taps an empty area of the screen:

* White
* Blue
* Green
* Orange
* Black

Text and icons automatically switch between black and white using `computeLuminance()` to ensure readability.

## Sample Tests

### Test 1

**Input:**

* Clear
* Morning

**Output:**

* Topwater Popper
* Natural Shad

### Test 2

**Input:**

* Stained
* Afternoon

**Output:**

* Crankbait
* Red Craw

### Edge Case

**Input:**

* No selections made

**Output:**

* "Please select water clarity."
* "Please select a time of day."

