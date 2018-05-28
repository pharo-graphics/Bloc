examples - advanced
bottomResizerBarInsideContainer
	<gtExample>
	| aContainer aResizer |

	aContainer := BlElement new.
	aContainer height: 300.
	aContainer constraintsDo: [ :c | c horizontal matchParent ].
	aContainer relocate: 0@50.
	aContainer border: (BlBorder paint: Color lightGray width: 1).

	aResizer := BlElement new.
	aResizer background: (Color gray alpha: 0.5).
	aResizer geometry: (BlRectangle cornerRadius: 2).
	aResizer constraintsDo: [ :c |
		c ignoreByLayout.
		c vertical exact: 4.
		c horizontal exact: 70.
		c ignored vertical alignBottom.
		c ignored horizontal alignCenter.
		c margin: (BlInsets bottom: 4) ].
	aResizer addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer).

	aContainer addChild: aResizer.

	^ aContainer