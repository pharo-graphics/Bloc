Class {
	#name : 'BlWrongScaleFactor',
	#superclass : 'Error',
	#instVars : [
		'scaleFactor'
	],
	#category : 'Bloc-Display-Errors',
	#package : 'Bloc-Display',
	#tag : 'Errors'
}

{ #category : 'instance creation' }
BlWrongScaleFactor class >> scaleFactor: aNumber [
	^ self new scaleFactor: aNumber
]

{ #category : 'accessing' }
BlWrongScaleFactor >> description [

	^ 'Wrong scale factor',  (scaleFactor
		ifNotNil: [ ' ({1})' format: { scaleFactor } ]
		ifNil: [ '' ])
]

{ #category : 'accessing' }
BlWrongScaleFactor >> scaleFactor: aNumber [
	scaleFactor := aNumber
]
