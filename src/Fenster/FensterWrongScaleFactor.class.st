Class {
	#name : #FensterWrongScaleFactor,
	#superclass : #FensterError,
	#instVars : [
		'scaleFactor'
	],
	#category : #'Fenster-Errors'
}

{ #category : #'instance creation' }
FensterWrongScaleFactor class >> scaleFactor: aNumber [
	^ self new scaleFactor: aNumber
]

{ #category : #accessing }
FensterWrongScaleFactor >> description [

	^ 'Wrong scale factor',  (scaleFactor
		ifNotNil: [ ' ({1})' format: { scaleFactor } ]
		ifNil: [ '' ])
]

{ #category : #accessing }
FensterWrongScaleFactor >> scaleFactor: aNumber [
	scaleFactor := aNumber
]
