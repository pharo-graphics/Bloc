Class {
	#name : #BlCompositionLayer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'creatorElement'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionLayer >> asSkiaLayer [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlCompositionLayer >> attachToParent: aCompositionLayer [
	parent := aCompositionLayer
]

{ #category : #accessing }
BlCompositionLayer >> children [
	^ #()
]

{ #category : #accessing }
BlCompositionLayer >> creatorElement [
	^ creatorElement
]

{ #category : #accessing }
BlCompositionLayer >> creatorElement: anObject [
	creatorElement := anObject
]

{ #category : #'as yet unclassified' }
BlCompositionLayer >> detachFromParent [
	parent := nil
]

{ #category : #drawing }
BlCompositionLayer >> drawOnSpartaCanvas: aCanvas [
]

{ #category : #'gt-extension' }
BlCompositionLayer >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #testing }
BlCompositionLayer >> hasParent [
	^ parent isNotNil
]

{ #category : #accessing }
BlCompositionLayer >> name [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
BlCompositionLayer >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				layout: BlLinearLayout vertical alignCenter;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
				border: (BlBorder paint: Color gray width: 1);
				background: Color white;
				when: BlClickEvent do: [ :anEvent | anEvent currentTarget phlow spawnObject: each ];
				zIndex: 10;
				addChildren: {
					BlTextElement new
						constraintsDo: [ :c | c padding: (BlInsets all: 1) ];
						text: each name asRopedText glamorousRegularFontAndSize } ];
		with: (self withDeepCollect: #children).
	view edges
		fromNearestBounds;
		toNearestBounds;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]

{ #category : #accessing }
BlCompositionLayer >> parent [
	<return: #BlCompositionLayer>

	^ parent
]

{ #category : #accessing }
BlCompositionLayer >> removeFromParent [
	self hasParent
		ifFalse: [ ^ self ].

	self parent removeChild: self
]
