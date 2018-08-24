Class {
	#name : #BlInfiniteExampleColorsDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'colors'
	],
	#category : 'Bloc-Infinite-Examples-Core - Colors'
}

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> blueAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians < (Float pi / 2.0)
		ifTrue: [ ^ 0 ].
	^ (radians - (Float pi / 2.0)) sin
]

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> colorAt: anIndex [
	| normalizedIndex |
	"0.0 <= anIndex <= 1.0"
	
	normalizedIndex := anIndex.
	"Because of float errors"
	normalizedIndex > 1 ifTrue: [ normalizedIndex := 1 ].
	normalizedIndex < 0 ifTrue: [ normalizedIndex := 0 ].
	
	^ Color
		r: (self redAt: normalizedIndex)
		g: (self greenAt: normalizedIndex)
		b: (self blueAt: normalizedIndex)
]

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> greenAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians > Float pi
		ifTrue: [ ^ 0 ].
	^ radians sin
]

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> initialize [
	super initialize.
	
	"colors := (Color registeredColorNames asOrderedCollection collect: [ :aName | Color named: aName asSymbol ])".
	colors := ((0 to: 1 by: 0.01) collect: [ :anIndex | self colorAt: anIndex ]) asOrderedCollection
]

{ #category : #accessing }
BlInfiniteExampleColorsDataSource >> itemCount [
	^ colors size
]

{ #category : #removing }
BlInfiniteExampleColorsDataSource >> moveColorDownAt: aNumber [
	| aColor |
	aNumber = self itemCount
		ifTrue: [ ^ self ].
	aColor := colors removeAt: aNumber.
	colors add: aColor afterIndex: aNumber.
	self notifyItemMoved: aNumber to: aNumber + 1
]

{ #category : #removing }
BlInfiniteExampleColorsDataSource >> moveColorUpAt: aNumber [
	| aColor |
	aNumber = 1
		ifTrue: [ ^ self ].
	aColor := colors removeAt: aNumber.
	colors add: aColor beforeIndex: aNumber.
	self notifyItemMoved: aNumber to: aNumber - 1
]

{ #category : #'instance creation' }
BlInfiniteExampleColorsDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder color: (colors at: aPosition)
]

{ #category : #'instance creation' }
BlInfiniteExampleColorsDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExampleColorElementHolder new
]

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> radiansAt: anIndex [
	"0.0 <= anIndex <= 1.0"
	self assert: [ anIndex between: 0.0 and: 1.0 ].
	
	^ anIndex * (Float pi * 3) / 2.0
]

{ #category : #initialization }
BlInfiniteExampleColorsDataSource >> redAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	(radians between: Float pi / 2.0 and: Float pi) 
		ifTrue: [ ^ 0 ].

	radians < (Float pi/ 2.0)
		ifTrue: [ ^ (radians + (Float pi / 2)) sin ].

	^ (radians + Float pi) sin
]

{ #category : #removing }
BlInfiniteExampleColorsDataSource >> removeColorAt: aNumber [
	colors removeAt: aNumber.
	self notifyItemsRemoved: (aNumber to: aNumber)
]
