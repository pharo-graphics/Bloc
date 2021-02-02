Class {
	#name : #BlZoomableLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'scaleFactor',
		'isDirty'
	],
	#category : #'Bloc-Layout-Zoomable'
}

{ #category : #initialization }
BlZoomableLayoutConstraints >> initialize [
	super initialize.
	
	scaleFactor := 1.
	isDirty := false
]

{ #category : #accessing }
BlZoomableLayoutConstraints >> isDirty [
	<return: #Boolean>

	^ isDirty
]

{ #category : #accessing }
BlZoomableLayoutConstraints >> isDirty: aBoolean [
	isDirty := aBoolean
]

{ #category : #accessing }
BlZoomableLayoutConstraints >> scaleFactor [
	^ scaleFactor
]

{ #category : #accessing }
BlZoomableLayoutConstraints >> scaleFactor: aNumber [
	scaleFactor = aNumber
		ifTrue: [ ^ self ].

	scaleFactor := aNumber.
	isDirty := true
]
