"
I an already measured abstract paragraph segment.
"
Class {
	#name : #BrTextParagraphSegment,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'left',
		'top',
		'width',
		'height',
		'ascent',
		'descent',
		'baseline',
		'from',
		'to',
		'paragraph'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BrTextParagraphSegment >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BrTextParagraphSegment >> baseline [
	<return: #Point>

	^ baseline
]

{ #category : #accessing }
BrTextParagraphSegment >> baseline: aPoint [
	baseline := aPoint
]

{ #category : #accessing }
BrTextParagraphSegment >> bounds [
	<return: #Rectangle>

	^ self origin extent: self extent
]

{ #category : #accessing }
BrTextParagraphSegment >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BrTextParagraphSegment >> extent [
	<return: #Point>

	^ self width @ self height
]

{ #category : #accessing }
BrTextParagraphSegment >> from [
	<return: #Number>

	^ from
]

{ #category : #accessing }
BrTextParagraphSegment >> height [
	<return: #Number>

	^ height
]

{ #category : #initialization }
BrTextParagraphSegment >> initialize [
	super initialize.

	left := 0.
	top := 0.
	width := 0.
	height := 0.
	
	baseline := 0@0.
	
	ascent := 0.
	descent := 0
]

{ #category : #accessing }
BrTextParagraphSegment >> left [
	<return: #Number>
	
	^ left
]

{ #category : #accessing }
BrTextParagraphSegment >> metrics [
	"Return a dictionary with segment metrics"
	<return: #Dictionary>
	
	^ {
		'Ascent' -> self ascent.
		'Descent' -> self descent.
		'Left' -> self left.
		'Top' -> self top.
		'Height' -> self height.
		'Width' -> self width.
		'Baseline' -> self baseline
	} asOrderedDictionary
]

{ #category : #measurement }
BrTextParagraphSegment >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSegment >> origin [
	<return: #Point>

	^ left @ top
]

{ #category : #accessing }
BrTextParagraphSegment >> paragraph [
	<return: #BrTextParagraph>

	^ paragraph
]

{ #category : #accessing }
BrTextParagraphSegment >> paragraph: aTextParagraph [

	self
		assert: [ aTextParagraph isNotNil ]
		description: [ 'Text paragraph must not be nil' ].

	paragraph := aTextParagraph
]

{ #category : #accessing }
BrTextParagraphSegment >> to [
	<return: #Number>

	^ to
]

{ #category : #accessing }
BrTextParagraphSegment >> top [
	<return: #Number>
	
	^ top
]

{ #category : #accessing }
BrTextParagraphSegment >> width [
	<return: #Number>

	^ width
]
