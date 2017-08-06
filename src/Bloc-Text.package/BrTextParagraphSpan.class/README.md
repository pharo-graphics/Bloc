I represent a single measured span within ===BrTextParagraph===.
Depending on the type of a paragraph (single or multi line) I can be either a direct child of ===BrTextParagraph=== or be contained inside of ===BrTextParagraphLine===.

A span consists of 3 essential parts:

	- underlying text span with span start and end indices
	- generated glyph text run with start and end indices used for measurement and rendering
	- various measurement metrics computed during measurement step by ===BrTextParagraphSpanMeasurer===