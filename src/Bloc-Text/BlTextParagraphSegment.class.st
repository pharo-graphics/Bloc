"
I an already measured abstract paragraph segment. I'm a composite to design lines (`BlTextParagraphLine`) and lines elements (`BlTextParagraphLeaf`). spans are canvas specific.



"
Class {
	#name : #BlTextParagraphSegment,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'left',
		'top',
		'width',
		'height',
		'advance',
		'ascent',
		'descent',
		'baseline'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BlTextParagraphSegment >> advance [

	^ advance
]

{ #category : #accessing }
BlTextParagraphSegment >> ascent [

	^ ascent
]

{ #category : #accessing }
BlTextParagraphSegment >> baseline [

	^ baseline
]

{ #category : #accessing }
BlTextParagraphSegment >> baseline: aPoint [

	baseline := aPoint
]

{ #category : #accessing }
BlTextParagraphSegment >> bounds [

	^ self origin extent: self extent
]

{ #category : #accessing }
BlTextParagraphSegment >> descent [

	^ descent
]

{ #category : #accessing }
BlTextParagraphSegment >> extent [

	^ width @ height
]

{ #category : #accessing }
BlTextParagraphSegment >> from [

	^ from
]

{ #category : #accessing }
BlTextParagraphSegment >> height [

	^ height
]

{ #category : #initialization }
BlTextParagraphSegment >> initialize [
	super initialize.

	from := 0.
	to := 0.

	left := 0.
	top := 0.
	width := 0.
	height := 0.
	advance := 0.
	
	baseline := 0@0.
	
	ascent := 0.
	descent := 0
]

{ #category : #accessing }
BlTextParagraphSegment >> left [
	
	^ left
]

{ #category : #measurement }
BlTextParagraphSegment >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSegment >> origin [

	^ left @ top
]

{ #category : #accessing }
BlTextParagraphSegment >> right [
	
	^ left + width
]

{ #category : #accessing }
BlTextParagraphSegment >> to [

	^ to
]

{ #category : #accessing }
BlTextParagraphSegment >> top [
	
	^ top
]

{ #category : #accessing }
BlTextParagraphSegment >> width [

	^ width
]
