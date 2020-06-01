Class {
	#name : #BlCompositionPainterStateTransformation,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #accessing }
BlCompositionPainterStateTransformation >> commandString [
	^ String streamContents: [ :aStream | self matrix decomposition asDictionary associations
		do: [ :eachAssociation | aStream
			nextPutAll: eachAssociation key;
			nextPutAll: ': ';
			nextPutAll: (eachAssociation value printString copyReplaceAll: String cr with: ' ') ]
		separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> matrix [
	^ matrix
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> matrix: anObject [
	matrix := anObject
]

{ #category : #hook }
BlCompositionPainterStateTransformation >> pushOn: aCanvas [
	aCanvas transform
		translateBy: offset;
		multiplyBy: matrix;
		push
]

{ #category : #hook }
BlCompositionPainterStateTransformation >> pushOnLayer: aSkiaOffsetLayer [	
	aSkiaOffsetLayer transform: self matrix offset: self offset
]

{ #category : #accessing }
BlCompositionPainterStateTransformation >> type [
	^ 'Transform'
]
