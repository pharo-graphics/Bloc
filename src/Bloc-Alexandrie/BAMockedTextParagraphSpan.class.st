Class {
	#name : #BAMockedTextParagraphSpan,
	#superclass : #BATextParagraphLeaf,
	#category : #'Bloc-Alexandrie-Mocked'
}

{ #category : #drawing }
BAMockedTextParagraphSpan >> aeDrawOn: aeCanvas [

	| freeTypeFont characterWidth characterHeight |
	self spanLength isZero ifTrue: [ ^ self ].

	freeTypeFont := fontAndStyleBuilder font asLogicalFont asFreetypeFont.
	cairoScaledFont := aeCanvas scaledFontFor: freeTypeFont.

	"Get glyphs for the text"
	characterWidth := (self width / self spanLength) asFloat.
	characterHeight := self height.
	
	" Draw each character one by one"
	self span asString withIndexDo: [ :c :index | 
		| buffer metrics bounds measuredWidth heightScale measuredHeight eachBaseline fixedBounds |
		eachBaseline := (self baseline + (index - 1 * (characterWidth @ 0))) x @ 0.
		buffer := c asString utf8Encoded.
		aeCanvas restoreContextAfter: [ 
		metrics := self getTextMetricsFor: buffer withBuilder: fontAndStyleBuilder canvas: aeCanvas].
		bounds := metrics at: #bounds.
		measuredWidth := bounds width.
		measuredWidth isZero ifTrue: [ measuredWidth := characterWidth ].
		measuredHeight := (metrics at: #ascent) abs + (metrics at: #descent).
		measuredHeight isZero ifTrue: [ measuredHeight := characterHeight ].
		heightScale := characterHeight * 0.8 / measuredHeight.
		fixedBounds := eachBaseline extent: characterWidth @ characterHeight.
		cairoGlyphsArray := cairoScaledFont glyphArrayFor: buffer length: buffer size.
		aeCanvas setSourceColor: (fontAndStyleBuilder hasCustomColor
				 ifTrue: [ fontAndStyleBuilder color ]
				 ifFalse: [ Color black ]).
				
		"Draw the border around the character"
		aeCanvas restoreContextAfter: [ 
			aeCanvas setBackgroundOff.
			" setOutskirtsInside otherwise the cursor is hidden"
			aeCanvas setOutskirtsInside.
			aeCanvas setBorderBlock: [ 
				aeCanvas setSourceColor: Color veryVeryLightGray lighter.
				aeCanvas setBorderWidth: 1.0 ].
			"Question : Why this pathTranslate ? it is not done in sparta, and it only approaching the sparta version because the top is not exactly the same "
			"aeCanvas pathTranslate: 0 @ ((metrics at: #ascent) abs + (metrics at: #descent)) negated."
			aeCanvas
				setPathKey: self
				hasJoins: true
				hasCaps: false
				block: [ :cairoContext | cairoContext rectangle: fixedBounds ].
			aeCanvas drawFigure ].
		
		"Draw the current character"
		aeCanvas restoreContextAfter: [ 
			aeCanvas pathTranslate: eachBaseline.
			aeCanvas pathScale: heightScale asPoint.
			"sparta version: " 
			aeCanvas pathTranslate: (bounds origin x negated) @ ((metrics at: #ascent) abs) + (characterWidth / heightScale - bounds width / 2.0 @ 0).
			" Question : why not the sparta version above ? It seems ok with the version below"
			"aeCanvas pathTranslate: (bounds origin x negated) @ 0 + (characterWidth / heightScale - bounds width / 2.0 @ 0)."
			self attributes do: [ :anAttribute | anAttribute aeDrawBelowOn: aeCanvas span: self ].
			aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont.
			self attributes do: [ :anAttribute | anAttribute aeDrawAboveOn: aeCanvas span: self ] ] ]
]

{ #category : #building }
BAMockedTextParagraphSpan >> applyFixedMetrics: aSpanMeasurer [

	width := aSpanMeasurer measuredWidth.
	height := aSpanMeasurer measuredHeight.
	
	ascent := aSpanMeasurer ascent.
	descent := aSpanMeasurer descent.

	left := 0.
	top := 0.
	advance := width.
	
	baseline := 0@0
]

{ #category : #accessing }
BAMockedTextParagraphSpan >> fontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder 
]
