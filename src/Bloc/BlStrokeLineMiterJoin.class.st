"
Extends the stroke to where the edges on each side bisect.
This is the initial value.

See BlStrokeLineJoin for other types
"
Class {
	#name : #BlStrokeLineMiterJoin,
	#superclass : #BlStrokeLineJoin,
	#category : #'Bloc-Paint-Support'
}

{ #category : #accessing }
BlStrokeLineMiterJoin class >> joinName [
	^ 'Miter'
]
