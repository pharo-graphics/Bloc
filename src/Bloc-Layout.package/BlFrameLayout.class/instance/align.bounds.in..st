layout
align: anElement bounds: elementBounds in: allowedBounds
	| x y delta |
	x := anElement constraints frame horizontal alignment horizontalTranslationFor: elementBounds in: allowedBounds.
	y := anElement constraints frame vertical alignment verticalTranslationFor: elementBounds in: allowedBounds.
	delta := x @ y.
	"fast return if there is no translation needed"
	delta isZero
		ifTrue: [ ^ elementBounds ].
	^ elementBounds translateBy: x @ y