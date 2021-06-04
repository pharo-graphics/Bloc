"
I am an {{gtClass:BlElement}}.
I visually display {{gtClass:BlVector2D}}.
## Examples
### 45° Vector
{{gtExample:BlVector2DDescriptionElementExamples>>#vectorDescriptionElement_45degrees|codeExpanded=false|previewExpanded=true|previewHeight=300|previewShow=#gtLiveFor:}}
### 270° Vector
{{gtExample:BlVector2DDescriptionElementExamples>>#vectorDescriptionElement_270degrees|codeExpanded=false|previewExpanded=true|previewHeight=300|previewShow=#gtLiveFor:}}
### Zero-length vector
{{gtExample:BlVector2DDescriptionElementExamples>>#vectorDescriptionElement_ZeroLength|codeExpanded=false|previewExpanded=true|previewHeight=300|previewShow=#gtLiveFor:}}


"
Class {
	#name : #BlVector2DDescriptionElement,
	#superclass : #BlElement,
	#instVars : [
		'vector',
		'circleElement',
		'lineElement',
		'textElement'
	],
	#category : #'Bloc-Extensions-Vector'
}

{ #category : #'private - asserting' }
BlVector2DDescriptionElement >> assertVector: aVector [
	self 
		assert: [ aVector isNotNil ] 
		description: [ 'Vector must be non-nil' ].
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> circleElement [
	<return: #BlElement>
	^ circleElement
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> degrees [
	<return: #Number>
	^ self vector degrees
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> description [
	<return: #Number>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'length = ';
			nextPutAll: (self length printShowingDecimalPlaces: 3).
		self hasLength ifTrue: [ 
			aStream 
				nextPutAll: ', degree = ';
				nextPutAll: (self degrees printShowingDecimalPlaces: 1);
				nextPut: $° ] ]
]

{ #category : #'private - testing' }
BlVector2DDescriptionElement >> hasLength [
	<return: #Boolean>
	^ self length isZero not
]

{ #category : #initialization }
BlVector2DDescriptionElement >> initialize [
	super initialize.

	self initializeCircleElement.
	self initializeLineElement.
	self initializeTextElement.
	self initializeElement.
	
	self addChild: self circleElement as: #circle.
	self circleElement addChild: self lineElement as: #line.
	self addChild: self textElement as: #description.
	
]

{ #category : #initialization }
BlVector2DDescriptionElement >> initializeCircleElement [
	circleElement := BlElement new
		layout: BlFrameLayout new;
		geometry: BlCircle new;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
]

{ #category : #initialization }
BlVector2DDescriptionElement >> initializeElement [
	self 
		layout: BlFrameLayout new;
		geometry: BlCircle new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c margin: (BlInsets all: 10) ].
]

{ #category : #initialization }
BlVector2DDescriptionElement >> initializeLineElement [
	lineElement := BlLineElement new
		border: (BlBorder paint: Color black width: 1);
		fromAnchor: (BlElementCenterAnchor element: self circleElement);
		toAnchor: (BlElementCenterRightAnchor element: self circleElement);
		visibility: BlVisibility gone.
]

{ #category : #initialization }
BlVector2DDescriptionElement >> initializeTextElement [
	textElement := BlTextElement new
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignTopAt: 0.5.
			c padding: (BlInsets all: 3) ];
		visibility: BlVisibility gone.
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> length [ 
	<return: #Number>
	^ self vector length 
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> lineElement [
	<return: #BlLineElement>
	^ lineElement
]

{ #category : #'private - hooks' }
BlVector2DDescriptionElement >> onVectorChanged [
	self updateElement.
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> text [
	^ self description asRopedText
]

{ #category : #'private - accessing' }
BlVector2DDescriptionElement >> textElement [
	<return: #BlTextElement>
	^ textElement
]

{ #category : #'private - updating' }
BlVector2DDescriptionElement >> updateElement [
	self updateLineElement.
	self updateTextElement.
]

{ #category : #'private - updating' }
BlVector2DDescriptionElement >> updateLineElement [
	self hasLength ifFalse: [ 
		self lineElement visibility: BlVisibility gone.
		^ self ].
	
	self lineElement visibility: BlVisibility visible.
	self circleElement transformDo: [ :aBuilder | 
		aBuilder rotateBy: self degrees ]
		
]

{ #category : #'private - updating' }
BlVector2DDescriptionElement >> updateTextElement [
	self textElement text: self text.
	
	(self hasLength and: [ self degrees between: 0 and: 180 ])
		ifTrue: [ 
			self textElement constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignBottomAt: 0.5 ] ]
		ifFalse: [ 
			self textElement constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignTopAt: 0.5 ] ].
	
	self textElement visibility: BlVisibility visible.

]

{ #category : #'api - accessing' }
BlVector2DDescriptionElement >> vector [
	<return: #BlVector2D>
	^ vector
]

{ #category : #'api - accessing' }
BlVector2DDescriptionElement >> vector: aVector [
	self assertVector: aVector.
	vector := aVector.
	self onVectorChanged.
]
