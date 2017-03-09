measuring
measureOn: aCanvas
	"Measure and create lines with text spans from provided rope
	based on attributes and layout properties (maximum width / height)"
	| anIterator aContext |

	aContext := SpMultilineTextLayoutContext new.
	aContext rope: rope.
	aContext maxWidth: maxWidth.
	aContext maxHeight: maxHeight.

	anIterator := rope iterator: 1 to: rope size.
	[ anIterator hasNext and: [ aContext availableHeight > 0 ] ] whileTrue: [ 
		| aLine |
		"If we pass while-check we definitely moved to the next line,
		so can do the same with position"
		aContext movePosition: anIterator position.
		aLine := anIterator nextLine.
		self initializeLine: aLine on: aCanvas with: aContext ].

	height := 0.
	aContext lines do: [ :aLine |
		aLine baseline: 0 @ (height + aLine ascent).
		width := width max: aLine width.
		height := height + aLine height ].
	
	lines := aContext lines.
	end := aContext position.