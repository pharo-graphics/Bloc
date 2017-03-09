*Bloc-Sparta
measureOnSpartaCanvas: aSpartaCanvas
	"Measure and create lines with text spans from provided rope
	based on attributes and layout properties (maximum width / height)"
	| anIterator aContext |

	aContext := SpSingleLineTextLayoutContext new.
	aContext text: text.
	aContext maxWidth: maxWidth.
	aContext maxHeight: maxHeight.

	anIterator := text iterator.
	[ anIterator hasNext ] whileTrue: [ 
		| aSpan |
		"If we pass while-check we definitely moved to the next line,
		so can do the same with position"
		aContext movePosition: anIterator position.
		aSpan := anIterator nextSpan.
		self measureSpan: aSpan onSpartaCanvas: aSpartaCanvas with: aContext ].

	height := 0.
	width := 0.
	aContext spans do: [ :aSpan |
		aSpan baseline: width @ (height + aSpan ascent).
		height := height max: aSpan height.
		width := width + aSpan width ].

	spans := aContext spans asArray.
	end := aContext position