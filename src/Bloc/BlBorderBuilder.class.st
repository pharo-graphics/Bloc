"
I am a BlBorder builder.

BlBorder builder
	paint: Color red;
	width: 10;
	build

"
Class {
	#name : 'BlBorderBuilder',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'paint',
		'width',
		'lineCap',
		'lineJoin',
		'miterLimit',
		'dashArray',
		'dashOffset',
		'opacity'
	],
	#category : 'Bloc-Basic-Border'
}

{ #category : 'builder' }
BlBorderBuilder >> build [
	^ BlBorder basicNew
		initialize;
		paint: self paint;
		width: self width;
		style: self buildStyle;
		opacity: self opacity;
		yourself
]

{ #category : 'builder' }
BlBorderBuilder >> buildStyle [
	^ BlStrokeStyle new
		lineCap: self lineCap;
		lineJoin: self lineJoin;
		miterLimit: self miterLimit;
		dashArray: self dashArray;
		dashOffset: self dashOffset
]

{ #category : 'api - line cap' }
BlBorderBuilder >> capButt [
	self lineCap: BlStrokeLineCap butt
]

{ #category : 'api - line cap' }
BlBorderBuilder >> capRound [
	self lineCap: BlStrokeLineCap round
]

{ #category : 'api - line cap' }
BlBorderBuilder >> capSquare [
	self lineCap: BlStrokeLineCap square
]

{ #category : 'accessing' }
BlBorderBuilder >> dashArray [
	^ dashArray
]

{ #category : 'accessing' }
BlBorderBuilder >> dashArray: anObject [
	dashArray := anObject
]

{ #category : 'accessing' }
BlBorderBuilder >> dashOffset [
	^ dashOffset
]

{ #category : 'accessing' }
BlBorderBuilder >> dashOffset: anObject [
	dashOffset := anObject
]

{ #category : 'styles' }
BlBorderBuilder >> dashed [
	dashOffset := 0.
	dashArray := #(6 4.2)
]

{ #category : 'styles' }
BlBorderBuilder >> dashedSmall [
	dashOffset := 0.
	dashArray := #(3 2)
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultDashArray [
	^ #()
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultDashOffset [
	^ 0.0
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultLineCap [
	^ BlStrokeLineCap butt
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultLineJoin [
	^ BlStrokeLineJoin miter
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultMiterLimit [
	^ 4.0
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultOpacity [
	^ 1.0
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultPaint [
	^ BlPaint transparent 
]

{ #category : 'initialization' }
BlBorderBuilder >> defaultWidth [
	^ 1.0
]

{ #category : 'initialization' }
BlBorderBuilder >> initialize [
	super initialize.
	
	paint := self defaultPaint.
	width := self defaultWidth.
	lineCap := self defaultLineCap.
	lineJoin := self defaultLineJoin.
	miterLimit := self defaultMiterLimit.
	dashArray := self defaultDashArray.
	dashOffset := self defaultDashOffset.
	opacity := self defaultOpacity
]

{ #category : 'styles' }
BlBorderBuilder >> joinRound [
	self lineJoin: BlStrokeLineJoin round
]

{ #category : 'api - line cap' }
BlBorderBuilder >> lineCap [
	<return: #BlStrokeLineCap>

	^ lineCap
]

{ #category : 'api - line cap' }
BlBorderBuilder >> lineCap: aBlStrokeLineCap [
	lineCap := aBlStrokeLineCap
]

{ #category : 'accessing' }
BlBorderBuilder >> lineJoin [
	<return: #BlStrokeLineJoin>

	^ lineJoin
]

{ #category : 'accessing' }
BlBorderBuilder >> lineJoin: aBlStrokeLineJoin [
	lineJoin := aBlStrokeLineJoin
]

{ #category : 'accessing' }
BlBorderBuilder >> miterLimit [
	^ miterLimit
]

{ #category : 'accessing' }
BlBorderBuilder >> miterLimit: anObject [
	miterLimit := anObject
]

{ #category : 'accessing' }
BlBorderBuilder >> opacity [
	^ opacity
]

{ #category : 'accessing' }
BlBorderBuilder >> opacity: anObject [
	opacity := anObject
]

{ #category : 'accessing' }
BlBorderBuilder >> paint [
	^ paint
]

{ #category : 'accessing' }
BlBorderBuilder >> paint: anObject [
	paint := anObject
]

{ #category : 'styles' }
BlBorderBuilder >> solid [
	dashOffset := 0.0.
	dashArray := #()
]

{ #category : 'accessing' }
BlBorderBuilder >> width [
	^ width
]

{ #category : 'accessing' }
BlBorderBuilder >> width: anObject [
	width := anObject
]
