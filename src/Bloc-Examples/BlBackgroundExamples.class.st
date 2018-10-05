Class {
	#name : #BlBackgroundExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'background - builder' }
BlBackgroundExamples >> buildBackgroundWithImagesAndColor [
	<gtExample>
	| aBackground aBuilder |
	
	aBuilder := BlBackground builder.
	aBuilder image
		form: PolymorphSystemSettings pharoLogoForm;
		opacity: 0.6.
	aBuilder image
		form: (Smalltalk ui icons iconNamed: #info).
	aBuilder paint
		paint: Color gray;
		opacity: 0.2.

	aBackground := aBuilder build.

	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground backgrounds size equals: 3.

	self assert: aBackground backgrounds first opacity equals: 0.6.
	self assert: aBackground backgrounds first image bits equals: PolymorphSystemSettings pharoLogoForm bits.

	self assert: aBackground backgrounds second opacity equals: 1.0.
	self assert: aBackground backgrounds second image bits equals: (Smalltalk ui icons iconNamed: #info) bits.

	self assert: aBackground backgrounds third opacity equals: 0.2.
	self assert: aBackground backgrounds third paint color equals: Color gray.

	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> emptyImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 0@0) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Form extent: 0@0) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> emptyImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 1@1) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Form extent: 1@1) bits.

	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> grayColorBackground [
	<gtExample>
	| aBackground |

	aBackground := Color gray asBlBackground.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> grayColorWithZeroOpacityBackground [
	<gtExample>
	| aBackground |

	aBackground := Color gray asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> imageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> imageWithZeroOpacityBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - transparent' }
BlBackgroundExamples >> transparentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := BlTransparentBackground new.

	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 1.0.

	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> transparentColorBackground [
	<gtExample>
	| aBackground |

	aBackground := Color transparent asBlBackground.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color transparent.

	^ aBackground
]
