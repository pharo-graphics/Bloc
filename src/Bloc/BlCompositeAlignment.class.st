Class {
	#name : 'BlCompositeAlignment',
	#superclass : 'BlElementAlignment',
	#instVars : [
		'vertical',
		'horizontal',
		'direction'
	],
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'instance creation' }
BlCompositeAlignment class >> horizontal: aHorizontalAlignent vertical: aVerticalAlignment [
	^ self new
		horizontal: aHorizontalAlignent vertical: aVerticalAlignment;
		yourself
]

{ #category : 'factory' }
BlCompositeAlignment >> directed: aBlLayoutDirection [
	direction := aBlLayoutDirection
]

{ #category : 'accessing' }
BlCompositeAlignment >> horizontal [
	^ horizontal
]

{ #category : 'initialization' }
BlCompositeAlignment >> horizontal: aHorizontalAlignent vertical: aVerticalAlignment [
	horizontal := aHorizontalAlignent.
	vertical := aVerticalAlignment
]

{ #category : 'initialization' }
BlCompositeAlignment >> initialize [
	super initialize.
	
	self leftToRight
]

{ #category : 'factory' }
BlCompositeAlignment >> inverted [
	^ (self class horizontal: (vertical inverted directed: direction) vertical: (horizontal directed: direction) inverted)
		directed: direction;
		yourself
]

{ #category : 'factory' }
BlCompositeAlignment >> leftToRight [
	direction := BlLayoutDirection leftToRight
]

{ #category : 'printing' }
BlCompositeAlignment >> printOn: aStream [
	aStream nextPut: $(.
	horizontal printOn: aStream.
	aStream nextPutAll: ', '.
	vertical printOn: aStream.
	aStream nextPut: $(.
	direction printOn: aStream.
	aStream nextPut: $).
	aStream nextPut: $)
]

{ #category : 'factory' }
BlCompositeAlignment >> rightToLeft [
	direction := BlLayoutDirection rightToLeft
]

{ #category : 'factory' }
BlCompositeAlignment >> swap [
	^ (self class horizontal: horizontal swap vertical: vertical swap)
			directed: direction;
			yourself
]

{ #category : 'translation' }
BlCompositeAlignment >> translationOf: aBounds in: aContainerBounds [
	| h v |
	h := (horizontal directed: direction) translationOf: aBounds in: aContainerBounds.
	v := (vertical directed: direction) translationOf: aBounds in: aContainerBounds.
	^ h + v
]

{ #category : 'accessing' }
BlCompositeAlignment >> vertical [
	^ vertical
]
