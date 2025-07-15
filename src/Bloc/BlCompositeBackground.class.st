"
I provide composition ability of multiple `BlBackground`.
I am useful when an Element should have both paint and image backgrounds.

Note: composed backgrounds are rendered in the same order they are defined in a composition. So for example if I was created as follows:

```
BlCompositeBackground withAll: {
	BlPaintBackground paint: Color red.
	BlImageBackground image: PolymorphSystemSettings pharoLogoForm
} 
```

Then image background will appear on top of paint background.

It is more convenient to create a composite background using `BlBackgroundBuilder`.

Opacity example:

```
	BlCompositeBackground new
		opacity: 0.5;
		withAll: {
			BlPaintBackground paint: Color red.
			BlImageBackground image: PolymorphSystemSettings pharoLogoForm
		} 
```
"
Class {
	#name : #BlCompositeBackground,
	#superclass : #BlBackground,
	#instVars : [
		'backgrounds'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlCompositeBackground class >> withAll: aCollectionOfBackground [

	^ self new
		withAll: aCollectionOfBackground;
		yourself
]

{ #category : #comparing }
BlCompositeBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject backgrounds = self backgrounds
]

{ #category : #accessing }
BlCompositeBackground >> backgrounds [
	"Return the collection of backgrounds that the receiver represents."

	^ backgrounds
]

{ #category : #comparing }
BlCompositeBackground >> hash [

	^ super hash bitXor: self backgrounds hash
]

{ #category : #testing }
BlCompositeBackground >> isTransparent [

	^ (self opacity closeTo: 0.0) or: [ self backgrounds allSatisfy: #isTransparent ]
]

{ #category : #geometry }
BlCompositeBackground >> matchExtent: anExtent [
	self backgrounds do: [ :aBackground | aBackground matchExtent: anExtent ]
]

{ #category : #initialization }
BlCompositeBackground >> withAll: aCollectionOfBackgrounds [
	"Return a composite background based on the collection of background pass as argument. 
	This collection of backgrounds must not be empty"

	backgrounds := aCollectionOfBackgrounds isArray
		               ifTrue: [ aCollectionOfBackgrounds copy ]
		               ifFalse: [ aCollectionOfBackgrounds asArray ]
]
