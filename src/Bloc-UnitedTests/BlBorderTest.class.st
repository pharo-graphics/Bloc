"
I have been automatically converted and probably manually tweaked from BlBorderExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlBorderTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Basic'
}

{ #category : #tests }
BlBorderTest >> testChangeOpacityError [

	<sampleInstance>
	| aBorder anError |
	aBorder := self testColorGrayBorder.

	[ aBorder opacity: 0.4 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #tests }
BlBorderTest >> testChangePaintError [

	<sampleInstance>
	| aBorder anError |
	aBorder := self testColorGrayBorder.

	[ aBorder paint: Color red ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #tests }
BlBorderTest >> testChangeStyleError [
	
	<sampleInstance>
	| aBorder anError |
	aBorder := self testColorGrayBorder.

	[ aBorder style: BlStrokeStyle default ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #tests }
BlBorderTest >> testChangeWidthError [

	<sampleInstance>
	| aBorder anError |
	aBorder := self testColorGrayBorder.

	[ aBorder width: 20 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #'test seed' }
BlBorderTest >> testColorGrayBorder [

	<sampleInstance>
	| aBorder |
	aBorder := BlBorder paint: Color gray.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #(  ).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #tests }
BlBorderTest >> testColorGrayBorderWithExplicitWidth [

	<sampleInstance>
	| aBorder |
	aBorder := BlBorder paint: Color gray width: 10.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #(  ).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 10.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #tests }
BlBorderTest >> testCopyWithOpacity [

	<sampleInstance>
	| anOldBorder aBorder |
	anOldBorder := self testColorGrayBorder.
	aBorder := anOldBorder copyWithOpacity: 0.5.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #(  ).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 0.5.

	^ aBorder
]

{ #category : #tests }
BlBorderTest >> testCopyWithPaint [

	<sampleInstance>
	| anOldBorder aBorder |
	anOldBorder := self testColorGrayBorder.
	aBorder := anOldBorder copyWithPaint: Color blue.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color blue.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray isEmpty.
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #tests }
BlBorderTest >> testCopyWithStyle [

	<sampleInstance>
	| anOldBorder aBorder |
	anOldBorder := self testColorGrayBorder.
	aBorder := anOldBorder copyWithStyle: BlStrokeStyle dashed.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #( 6 4.2 ).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #tests }
BlBorderTest >> testCopyWithWidth [

	<sampleInstance>
	| anOldBorder aBorder |
	anOldBorder := self testColorGrayBorder.
	aBorder := anOldBorder copyWithWidth: 10.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #(  ).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 10.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]
