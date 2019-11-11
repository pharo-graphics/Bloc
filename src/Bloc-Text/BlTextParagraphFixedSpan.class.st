Class {
	#name : #BlTextParagraphFixedSpan,
	#superclass : #BlTextParagraphSpan,
	#category : #'Bloc-Text-Text-Mocked'
}

{ #category : #accessing }
BlTextParagraphFixedSpan >> advance: aNumber [
	advance := aNumber
]

{ #category : #drawing }
BlTextParagraphFixedSpan >> drawOnSpartaCanvas: aSpartaCanvas [
	| theAttributes aTextPainter aFontBuilder aCharacterWidth aCharacterHeight |
	
	self spanLength isZero
		ifTrue: [ ^ self ].
	
	theAttributes := self attributes.

	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.

	theAttributes do: [ :anAttribute |
		anAttribute drawBelowOnSpartaCanvas: aSpartaCanvas with: self.
		anAttribute applyOnSpartaFontBuilder: aFontBuilder with: self.
		anAttribute applyOnSpartaTextPainter: aTextPainter with: self ].

	aTextPainter
		font: aFontBuilder build;
		string: self textRun.

	aCharacterWidth := (self width / self textRunLength) asFloat.
	aCharacterHeight := self height.
	
	self textRunStart to: self textRunEnd do: [ :anIndex |
		| theMetrics theBounds aMeasuredWidth aMeasuredHeight aHeightScale eachBaseline theFixedBounds |

		eachBaseline := (self baseline + ((anIndex - 1) * (aCharacterWidth @ 0))) x @ 0.
	
		theMetrics := aTextPainter
			start: anIndex;
			end: anIndex;
			measure.
		
		theBounds := theMetrics textMetrics bounds.

		aMeasuredWidth := theBounds width.
		aMeasuredWidth isZero
			ifTrue: [ aMeasuredWidth := aCharacterWidth ].
		aMeasuredHeight := theMetrics fontMetrics ascent + theMetrics fontMetrics descent.
		aMeasuredHeight isZero
			ifTrue: [ aMeasuredHeight := aCharacterHeight ].
		
		aHeightScale := (aCharacterHeight * 0.8) / aMeasuredHeight.
		
		theFixedBounds := (eachBaseline extent: aCharacterWidth @ aCharacterHeight).

		aSpartaCanvas stroke
			path: theFixedBounds;
			paint: Color veryVeryLightGray lighter;
			width: 1;
			draw.

		aSpartaCanvas transform
			by: [ :aTransform |
				aTransform translateBy: eachBaseline.
				aTransform scaleBy: aHeightScale.
				aTransform translateBy: (theBounds origin x negated @ theMetrics fontMetrics ascent) + ((aCharacterWidth / aHeightScale) - (theBounds width) / 2.0 @ 0) ]
			during: [ aTextPainter draw ].
		
		
			aSpartaCanvas text
				string: (anIndex - 1) asString;
				font: (aSpartaCanvas font size: aCharacterHeight * 0.22; build);
				baseline: ((eachBaseline x - 2) @ (self height - 1));
				paint: Color gray;
				draw.

		aSpartaCanvas text
			string: (anIndex) asString;
			font: (aSpartaCanvas font size: aCharacterHeight * 0.22; build);
			baseline: ((eachBaseline x + aCharacterWidth - 2) @ (self height - 1));
			paint: Color gray;
			draw ].

	"And finally let attributes to render above the text"
	theAttributes do: [ :anAttribute |
		anAttribute drawAboveOnSpartaCanvas: aSpartaCanvas with: self ]
]

{ #category : #accessing }
BlTextParagraphFixedSpan >> left: aNumber [
	left := aNumber
]
