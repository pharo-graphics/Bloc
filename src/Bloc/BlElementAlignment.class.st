"
I represent alignment layout property.

I calculate needed horizontal and vertical translation of BlElement to be aligned to the left, middle or to the right within allowed bounds.

I may be used by layout strategies that support alignment, for example Frame Layout

Public API and Key Messages

- horizontalTranslationFor: elementBounds in: allowedBounds calculate horizontal translation
- verticalTranslationFor: elementBounds in: allowedBounds calculate vertical translation
- new to create instances.
 
Internal Representation and Key Implementation Points.
both element and allowed bounds should be in element's parent coordinate system

"
Class {
	#name : 'BlElementAlignment',
	#superclass : 'Object',
	#classInstVars : [
		'end',
		'horizontal',
		'middle',
		'null',
		'start',
		'vertical'
	],
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlElementAlignment class >> bottom [
	^ self vertical end
]

{ #category : 'factory' }
BlElementAlignment class >> center [
	^ self middle
]

{ #category : 'factory' }
BlElementAlignment class >> end [
	^ end
]

{ #category : 'factory' }
BlElementAlignment class >> horizontal [
	^ horizontal
]

{ #category : 'class initialization' }
BlElementAlignment class >> initialize [
	super initialize.
	
	start := BlStartAlignment new.
	middle := BlMiddleAlignment new.
	end := BlEndAlignment new.
	null := BlNullAlignment new.
	horizontal := BlHorizontalAlignment new.
	vertical := BlVerticalAlignment new
]

{ #category : 'factory' }
BlElementAlignment class >> left [
	^ self horizontal class left
]

{ #category : 'factory' }
BlElementAlignment class >> middle [
	^ middle
]

{ #category : 'factory' }
BlElementAlignment class >> null [
	^ null
]

{ #category : 'factory' }
BlElementAlignment class >> right [
	^ self horizontal class right
]

{ #category : 'factory' }
BlElementAlignment class >> start [
	^ start
]

{ #category : 'factory' }
BlElementAlignment class >> top [
	^ self vertical start
]

{ #category : 'factory' }
BlElementAlignment class >> vertical [
	^ vertical
]

{ #category : 'composition' }
BlElementAlignment >> + anElementAlignment [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
BlElementAlignment >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'comparing' }
BlElementAlignment >> hash [
	^ self class hash
]

{ #category : 'testing' }
BlElementAlignment >> ifNotNull: aBlock [
	aBlock value
]

{ #category : 'testing' }
BlElementAlignment >> ifNull: aBlock [
	"not null"
]

{ #category : 'translation' }
BlElementAlignment >> translationOf: aBounds in: aContainerBounds [
	^ self subclassResponsibility
]
