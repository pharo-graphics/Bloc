"
I represent a abstract layout orientation.

I am used by layouts that support different orientations and by element alignment.
I do not have any logic and can only used as orientation flag. Layouts that have orientation specific logic should impelment their own object oriented mechanism

"
Class {
	#name : 'BlLayoutOrientation',
	#superclass : 'Object',
	#classVars : [
		'horizontal',
		'vertical'
	],
	#category : 'Bloc-Layouts-Support',
	#package : 'Bloc',
	#tag : 'Layouts-Support'
}

{ #category : 'factory' }
BlLayoutOrientation class >> horizontal [
	^ horizontal
]

{ #category : 'class initialization' }
BlLayoutOrientation class >> initialize [
	super initialize.
	
	horizontal := BlLayoutHorizontal new.
	vertical := BlLayoutVertical new
]

{ #category : 'factory' }
BlLayoutOrientation class >> vertical [
	^ vertical
]

{ #category : 'testing' }
BlLayoutOrientation >> isHorizontal [
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlLayoutOrientation >> isVertical [
	^ self subclassResponsibility
]

{ #category : 'dispatch' }
BlLayoutOrientation >> of: anObject [
	^ self subclassResponsibility
]
