Class {
	#name : #BlFlowLayoutLineSpace,
	#superclass : #Object,
	#instVars : [
		'intervals'
	],
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #initialization }
BlFlowLayoutLineSpace >> initializeFor: aCollectionOfFloatingChildren maxLength: aNumber [
	"By definition floating elements can not overlap"
	| endOfOccupiedSpace maxLength |
	
	maxLength := aNumber isInfinite
		ifTrue: [ SmallInteger maxVal ]
		ifFalse: [ aNumber ].
	
	aCollectionOfFloatingChildren ifEmpty: [ 
		intervals := { 0 to: maxLength }.
		^ self ].
	
	intervals := OrderedCollection new.
	endOfOccupiedSpace := aCollectionOfFloatingChildren inject: 0 into: [ :aStart :aChild |
			aStart = aChild startLength
				ifFalse: [ intervals add: (aStart to: aChild startLength) ].
			aChild startLength + aChild totalLength ].
	
	intervals add: (endOfOccupiedSpace to: maxLength)
]

{ #category : #accessing }
BlFlowLayoutLineSpace >> intervals [
	^ intervals
]

{ #category : #accessing }
BlFlowLayoutLineSpace >> lineStart [
	^ intervals first first
]
