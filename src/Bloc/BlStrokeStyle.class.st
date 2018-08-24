Class {
	#name : #BlStrokeStyle,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'lineCap',
		'lineJoin',
		'miterLimit',
		'dashArray',
		'dashOffset'
	],
	#category : 'Bloc-Paint-Support'
}

{ #category : #copying }
BlStrokeStyle >> copyWithLineCap: aLineCap [
	^ self copy lineCap: aLineCap
]

{ #category : #copying }
BlStrokeStyle >> copyWithLineJoin: aLineJoin [
	^ self copy lineJoin: aLineJoin
]

{ #category : #accessing }
BlStrokeStyle >> dashArray [
	^ dashArray
]

{ #category : #accessing }
BlStrokeStyle >> dashArray: anArray [
	dashArray := anArray
]

{ #category : #accessing }
BlStrokeStyle >> dashOffset [
	^ dashOffset
]

{ #category : #accessing }
BlStrokeStyle >> dashOffset: aNumber [
	dashOffset := aNumber
]

{ #category : #accessing }
BlStrokeStyle >> lineCap [
	^ lineCap
]

{ #category : #accessing }
BlStrokeStyle >> lineCap: aBlStrokeLineCap [
	lineCap := aBlStrokeLineCap
]

{ #category : #accessing }
BlStrokeStyle >> lineJoin [
	^ lineJoin
]

{ #category : #accessing }
BlStrokeStyle >> lineJoin: aBlStrokeLineJoin [
	lineJoin := aBlStrokeLineJoin
]

{ #category : #accessing }
BlStrokeStyle >> miterLimit [
	^ miterLimit
]

{ #category : #accessing }
BlStrokeStyle >> miterLimit: aNumber [
	miterLimit := aNumber
]
