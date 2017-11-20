hooks
lastSpanAdded
	| thePrevious theLast previousBottom newBottom |

	thePrevious := spans at: (spans size - 1).
	theLast := spans last.

	theLast baseline: thePrevious baseline + (thePrevious advance @ 0).

	previousBottom := top + height.
	newBottom := theLast top + theLast height.
	top := top min: theLast top.
	height := height max: ((previousBottom max: newBottom) - top).

	width := theLast baseline x + theLast left + theLast width.

	ascent := ascent max: theLast ascent.
	descent := descent max: theLast descent.

	to := theLast to