"
I provide composition ability of multiple ===BlBackground===.
I am useful when an Element should have both paint and image backgrounds.

Note: composed backgrounds are rendered in the same order they are defined in a composition. So for example if I was created as follows:

BlCompositeBackground withAll: {
	BlPaintBackground paint: Color red.
	BlImageBackground image: PolymorphSystemSettings pharoLogoForm
} 

then image background will appear on top of paint background.

It is more convenient to create a composite background using ===BlBackgroundBuilder===

Opacity example:

	BlCompositeBackground new
		opacity: 0.5;
		withAll: {
			BlPaintBackground paint: Color red.
			BlImageBackground image: PolymorphSystemSettings pharoLogoForm
		} 
"
Class {
	#name : #BlCompositeBackground,
	#superclass : #BlBackground,
	#instVars : [
		'backgrounds'
	],
	#category : 'Bloc-Basic-Visual'
}

{ #category : #'instance creation' }
BlCompositeBackground class >> withAll: aCollectionOfBackground [
	^ self new withAll: aCollectionOfBackground
]

{ #category : #accessing }
BlCompositeBackground >> backgrounds [
	<return: #Collection of: #BlBackground>

	^ backgrounds
]

{ #category : #initialization }
BlCompositeBackground >> initialize [
	super initialize.
	
	backgrounds := OrderedCollection new
]

{ #category : #testing }
BlCompositeBackground >> isTransparent [
	<return: #Boolean>

	^ backgrounds allSatisfy: #isTransparent
]

{ #category : #geometry }
BlCompositeBackground >> matchExtent: anExtent [
	backgrounds do: [ :aBackground | aBackground matchExtent: anExtent ]
]

{ #category : #adding }
BlCompositeBackground >> withAll: aCollectionOfBackgrounds [
	self
		assert: [ aCollectionOfBackgrounds isNotNil ]
		description: [ 'Collection must not be nil' ].
	self
		assert: [ aCollectionOfBackgrounds allSatisfy: #isNotNil ]
		description: [ 'All backgrounds must not be nil' ].
	self
		assert: [ aCollectionOfBackgrounds isNotEmpty ]
		description: [ 'Collection of background must not be empty' ].

	backgrounds := aCollectionOfBackgrounds asArray copy
]
