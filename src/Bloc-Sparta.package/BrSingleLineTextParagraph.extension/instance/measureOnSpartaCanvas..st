*Bloc-Sparta
measureOnSpartaCanvas: aSpartaCanvas
	"Measure and create lines with text spans from provided rope
	based on attributes and layout properties (maximum width / height)"
	| anIterator aContext anAscent |

	aContext := BrSingleLineTextParagraphContext new.
	aContext maxWidth: maxWidth.
	aContext maxHeight: maxHeight.

	anIterator := text iterator.
	[ anIterator hasNext ] whileTrue: [ 
		| aBrSpan |
		"If we pass while-check we definitely moved to the next line,
		so can do the same with position"
		aContext movePosition: anIterator position.
		aBrSpan := anIterator nextSpan.
		self measureSpan: aBrSpan onSpartaCanvas: aSpartaCanvas with: aContext ].

	height := 0.0.
	width := 0.0.
	anAscent := 0.0.
	
	aContext spans do: [ :aSpan |
		anAscent := anAscent max: aSpan ascent ].
	
	aContext spans do: [ :aSpan |
		aSpan baseline: width @ anAscent.
		height := height max: aSpan height.
		width := width + aSpan width ].

	spans := aContext spans asArray.
	end := aContext position