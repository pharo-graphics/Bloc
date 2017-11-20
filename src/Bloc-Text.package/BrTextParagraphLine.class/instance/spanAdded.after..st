hooks
spanAdded: aLastSpan after: aPreviousSpan
	| previousBottom newBottom |
	
	aLastSpan baseline: aPreviousSpan baseline + (aPreviousSpan advance @ 0).

	previousBottom := top + height.
	newBottom := aLastSpan top + aLastSpan height.
	top := top min: aLastSpan top.
	height := height max: ((previousBottom max: newBottom) - top).

	width := aLastSpan baseline x + aLastSpan left + aLastSpan width.

	ascent := ascent max: aLastSpan ascent.
	descent := descent max: aLastSpan descent.

	to := aLastSpan to