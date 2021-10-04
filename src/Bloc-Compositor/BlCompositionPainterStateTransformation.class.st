Class {
	#name : #BlCompositionPainterStateTransformation,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #converting }
BlCompositionPainterStateTransformation >> asSymbolTree [
	^ { #Transform . self matrix asMatrixCollection asArray }
]

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

{ #category : #'mathematical functions' }
BlCompositionPainterStateTransformation >> multiplyOn: aBlMatrix2D [
	aBlMatrix2D translateBy: self offset.
	aBlMatrix2D multiplyBy: self matrix
]

{ #category : #hook }
BlCompositionPainterStateTransformation >> popOn: aCanvas [
	aCanvas transform
		translateBy: offset;
		multiplyBy: matrix;
		pop
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
