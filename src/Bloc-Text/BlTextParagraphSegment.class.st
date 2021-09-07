"
I an already measured abstract paragraph segment.

"
Class {
	#name : 'BlTextParagraphSegment',
	#superclass : 'Object',
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
		'advance',
		'paragraph'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : 'accessing' }
BlTextParagraphSegment >> advance [
	<return: #Number>

	^ advance
]

{ #category : 'accessing' }
BlTextParagraphSegment >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : 'accessing' }
BlTextParagraphSegment >> baseline [
	<return: #Point>

	^ baseline
]

{ #category : 'accessing' }
BlTextParagraphSegment >> baseline: aPoint [
	baseline := aPoint
]

{ #category : 'accessing' }
BlTextParagraphSegment >> bounds [
	<return: #Rectangle>

	^ self origin extent: self extent
]

{ #category : 'accessing' }
BlTextParagraphSegment >> descent [
	<return: #Number>

	^ descent
]

{ #category : 'accessing' }
BlTextParagraphSegment >> extent [
	<return: #Point>

	^ self width @ self height
]

{ #category : 'accessing' }
BlTextParagraphSegment >> from [
	<return: #Number>

	^ from
]

{ #category : 'accessing' }
BlTextParagraphSegment >> height [
	<return: #Number>

	^ height
]

{ #category : 'initialization' }
BlTextParagraphSegment >> initialize [
	super initialize.

	left := 0.
	top := 0.
	width := 0.
	height := 0.
	advance := 0.
	
	baseline := 0@0.
	
	ascent := 0.
	descent := 0
]

{ #category : 'accessing' }
BlTextParagraphSegment >> left [
	<return: #Number>
	
	^ left
]

{ #category : 'accessing' }
BlTextParagraphSegment >> metrics [
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

{ #category : 'measurement' }
BlTextParagraphSegment >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self subclassResponsibility
]

{ #category : 'accessing' }
BlTextParagraphSegment >> origin [
	<return: #Point>

	^ left @ top
]

{ #category : 'accessing' }
BlTextParagraphSegment >> paragraph [
	<return: #BlTextParagraph>

	^ paragraph
]

{ #category : 'accessing' }
BlTextParagraphSegment >> paragraph: aTextParagraph [

	self
		assert: [ aTextParagraph isNotNil ]
		description: [ 'Text paragraph must not be nil' ].

	paragraph := aTextParagraph
]

{ #category : 'accessing' }
BlTextParagraphSegment >> right [
	<return: #Number>
	
	^ left + width
]

{ #category : 'accessing' }
BlTextParagraphSegment >> to [
	<return: #Number>

	^ to
]

{ #category : 'accessing' }
BlTextParagraphSegment >> top [
	<return: #Number>
	
	^ top
]

{ #category : 'accessing' }
BlTextParagraphSegment >> width [
	<return: #Number>

	^ width
]
