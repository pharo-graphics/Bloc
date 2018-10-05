Class {
	#name : #BlBackgroundExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

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
