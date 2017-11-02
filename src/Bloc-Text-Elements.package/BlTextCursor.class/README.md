I represent a cursor specified by position in text.

Position can only be given within valid text bounds with the only exception of 0.
When position is 0 cursor should appear before the first character, when position is equal to ===text size=== a cursor should appear after the last text character.

Cursor with position 0 of an empty text should appear where the first character would be if it would be added.