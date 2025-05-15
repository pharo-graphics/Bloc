Class {
	#name : #BASharedCairoMatrix,
	#superclass : #ProcessSpecificVariable,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #accessing }
BASharedCairoMatrix >> default [

	(matrix isNil or: [ matrix isNull ]) ifTrue: [
		matrix := AeCairoMatrix externalNew ].

	^ matrix
]
