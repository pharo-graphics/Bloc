Class {
	#name : #BlCompositionLayer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'needsComposition',
		'session'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #printing }
BlCompositionLayer class >> printSymbolTree: anArray [
	^ String streamContents: [ :aStream | self printSymbolTree: anArray on: aStream ]
]

{ #category : #printing }
BlCompositionLayer class >> printSymbolTree: anArray on: aStream [
	aStream nextPut: $#.
	self printSymbolTree: anArray on: aStream depth: 0.
]

{ #category : #printing }
BlCompositionLayer class >> printSymbolTree: anArray on: aStream depth: aDepth [
	| thePropertiesArray |
	aStream
		nextPut: $(;
		nextPutAll: anArray first.
	
	thePropertiesArray := anArray allButFirst.
	thePropertiesArray pairsDo: [ :eachName :eachProperty |
		aStream
			cr;
			space: (aDepth + 1) * 2;
			nextPutAll: eachName; space;
			print: eachProperty ].
		
	thePropertiesArray size odd
		ifTrue: [
			aStream cr.
			aStream space: (aDepth + 1) * 2; nextPut: $(.
			thePropertiesArray last withIndexDo: [ :eachSubTree :eachIndex |
				eachIndex > 1
					ifTrue: [ aStream cr; space: (aDepth + 1) * 2 ].
				self printSymbolTree: eachSubTree on: aStream depth: aDepth + 1 ].
			aStream nextPut: $). ].
	aStream nextPut: $).
]

{ #category : #accessing }
BlCompositionLayer >> allParents [
	^ Array streamContents: [ :aStream | self parentsDo: [ :eachParent | aStream nextPut: eachParent ] ]
]

{ #category : #converting }
BlCompositionLayer >> asExplosionElement [
	<return: #BlElement>
	| aContainer theBounds |

	aContainer := BlElement new.
	aContainer clipChildren: false.
	aContainer constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	theBounds := nil.
	
	self pictureLayersDo: [ :eachPictureLayer |
		| aPictureElement pictureBounds |
		
		pictureBounds := (BlBounds fromRectangle: eachPictureLayer picture bounds).
		
		aPictureElement := eachPictureLayer asElement.
		
		eachPictureLayer needsCache
			ifTrue: [ aPictureElement background: (Color gray alpha: 0.15) ].
		aPictureElement zIndex: eachPictureLayer depth.
		aPictureElement transformDo: [ :t |
			t
				topLeftOrigin;
					matrix: eachPictureLayer totalMatrix;
					scaleBy: 0.8@1;
					skewX: 30;
					rotateBy: 30;
					translateBy: (0 @ 30) negated * eachPictureLayer depth ].
	
		aPictureElement localBoundsToParent: pictureBounds.
		theBounds
			ifNil: [ theBounds := pictureBounds ]
			ifNotNil: [ theBounds merge: pictureBounds ].
		
		aContainer addChild: aPictureElement ].
	
	^ theBounds
		ifNil: [ aContainer ]
		ifNotNil: [
			| aWrapper |			
			aContainer size: theBounds extent.
			aContainer transformDo: [ :t | t translateBy: theBounds origin negated ].
			
			aWrapper := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				addChild: aContainer.
				
			aWrapper asScalableElement ]
]

{ #category : #converting }
BlCompositionLayer >> asSkiaLayer [
	^ self subclassResponsibility
]

{ #category : #converting }
BlCompositionLayer >> asSymbolTree [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlCompositionLayer >> attachToParent: aCompositionLayer [
	parent := aCompositionLayer
]

{ #category : #accessing }
BlCompositionLayer >> children [
	^ #()
]

{ #category : #'private - composition' }
BlCompositionLayer >> cleanNeedsComposition [
	needsComposition := false
]

{ #category : #'private - composition' }
BlCompositionLayer >> cleanNeedsCompositionFromAllLayers [
	self cleanNeedsComposition
]

{ #category : #'private - composition' }
BlCompositionLayer >> computeNeedsComposition [
	
]

{ #category : #accessing }
BlCompositionLayer >> detachFromParent [
	parent := nil
]

{ #category : #drawing }
BlCompositionLayer >> drawOnSpartaCanvas: aCanvas [
]

{ #category : #testing }
BlCompositionLayer >> hasParent [
	^ parent isNotNil
]

{ #category : #initialization }
BlCompositionLayer >> initialize [
	super initialize.
	
	needsComposition := true.
	session := Smalltalk session
]

{ #category : #testing }
BlCompositionLayer >> isValid [
	<return: #Boolean>
	
	^ session == Smalltalk session
]

{ #category : #'private - composition' }
BlCompositionLayer >> markNeedsComposition [
	needsComposition := true.
]

{ #category : #'private - context' }
BlCompositionLayer >> multiplyOn: aBlMatrix2D [
	
]

{ #category : #accessing }
BlCompositionLayer >> name [
	^ self subclassResponsibility
]

{ #category : #'private - composition' }
BlCompositionLayer >> needsComposition [
	^ needsComposition
]

{ #category : #accessing }
BlCompositionLayer >> parent [
	<return: #BlCompositionLayer>

	^ parent
]

{ #category : #accessing }
BlCompositionLayer >> parentSuchThat: aSelectBlock do: aFoundBlock [
	self allParents detect: aSelectBlock ifFound: aFoundBlock
]

{ #category : #accessing }
BlCompositionLayer >> parentsDo: aBlock [
	self hasParent
		ifTrue: [
			aBlock value: self parent.
			self parent parentsDo: aBlock ]
]

{ #category : #'private - context' }
BlCompositionLayer >> pictureLayersDo: aBlock [
]

{ #category : #accessing }
BlCompositionLayer >> removeFromParent [
	self hasParent
		ifFalse: [ ^ self ].

	self parent removeLayer: self
]

{ #category : #accessing }
BlCompositionLayer >> reversedParentsDo: aBlock [
	self hasParent
		ifTrue: [
			self parent parentsDo: aBlock.
			aBlock value: self parent ]
]
