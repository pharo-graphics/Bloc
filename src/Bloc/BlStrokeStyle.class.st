Class {
	#name : 'BlStrokeStyle',
	#superclass : 'Object',
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

{ #category : 'instance creation' }
BlStrokeStyle class >> dashed [
	<gtExample>
	^ self new
		lineCap: BlStrokeLineCap butt;
		lineJoin: BlStrokeLineJoin miter;
		miterLimit: 4.0;
		dashArray: #(6 4.2);
		dashOffset: 0
]

{ #category : 'instance creation' }
BlStrokeStyle class >> default [
	<gtExample>
	^ self new
		lineCap: BlStrokeLineCap butt;
		lineJoin: BlStrokeLineJoin miter;
		miterLimit: 4.0;
		dashArray: #();
		dashOffset: 0
]

{ #category : 'comparing' }
BlStrokeStyle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ miterLimit = anObject miterLimit
		and: [ dashArray = anObject dashArray
				and: [ dashOffset = anObject dashOffset
						and: [ lineCap = anObject lineCap and: [ lineJoin = anObject lineJoin ] ] ] ]
]

{ #category : 'copying' }
BlStrokeStyle >> copyWithLineCap: aLineCap [
	^ self copy lineCap: aLineCap
]

{ #category : 'copying' }
BlStrokeStyle >> copyWithLineJoin: aLineJoin [
	^ self copy lineJoin: aLineJoin
]

{ #category : 'accessing' }
BlStrokeStyle >> dashArray [
	^ dashArray
]

{ #category : 'accessing' }
BlStrokeStyle >> dashArray: anArray [
	dashArray := anArray
]

{ #category : 'accessing' }
BlStrokeStyle >> dashOffset [
	^ dashOffset
]

{ #category : 'accessing' }
BlStrokeStyle >> dashOffset: aNumber [
	dashOffset := aNumber
]

{ #category : 'comparing' }
BlStrokeStyle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ miterLimit hash
		bitXor:
			(dashArray hash
				bitXor: (dashOffset hash bitXor: (lineCap hash bitXor: lineJoin hash)))
]

{ #category : 'accessing' }
BlStrokeStyle >> lineCap [
	^ lineCap
]

{ #category : 'accessing' }
BlStrokeStyle >> lineCap: aBlStrokeLineCap [
	lineCap := aBlStrokeLineCap
]

{ #category : 'accessing' }
BlStrokeStyle >> lineJoin [
	^ lineJoin
]

{ #category : 'accessing' }
BlStrokeStyle >> lineJoin: aBlStrokeLineJoin [
	lineJoin := aBlStrokeLineJoin
]

{ #category : 'accessing' }
BlStrokeStyle >> miterLimit [
	^ miterLimit
]

{ #category : 'accessing' }
BlStrokeStyle >> miterLimit: aNumber [
	miterLimit := aNumber
]
