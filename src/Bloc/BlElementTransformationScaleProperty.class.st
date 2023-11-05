Class {
	#name : 'BlElementTransformationScaleProperty',
	#superclass : 'BlElementProperty',
	#instVars : [
		'scaleFactor'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'comparing' }
BlElementTransformationScaleProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ scaleFactor = anObject scaleFactor
]

{ #category : 'api - property' }
BlElementTransformationScaleProperty >> applyOnElement: anElement [
	anElement transformDo: [ :t | t scaleBy: self scaleFactor ]
]

{ #category : 'initialization' }
BlElementTransformationScaleProperty >> cleanUpOnElement: anElement [
	anElement transformDo: [ :t | t scaleBy: 1 ]
]

{ #category : 'comparing' }
BlElementTransformationScaleProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ scaleFactor hash
]

{ #category : 'initialization' }
BlElementTransformationScaleProperty >> initialize [
	super initialize.
	
	scaleFactor := 1
]

{ #category : 'accessing' }
BlElementTransformationScaleProperty >> scaleFactor [
	^ scaleFactor
]

{ #category : 'accessing' }
BlElementTransformationScaleProperty >> scaleFactor: anObject [
	scaleFactor := anObject
]
