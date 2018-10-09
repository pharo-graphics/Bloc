Class {
	#name : #BlBorderExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'examples - immutability' }
BlBorderExamples >> changeOpacityError [
	<gtExample>
	| aBorder anError |

	aBorder := self colorGrayBorder.

	[ aBorder opacity: 0.4 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].
	
	self assert: (anError isKindOf: BlImmutableObjectChangeError).
	
	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changePaintError [
	<gtExample>
	| aBorder anError |

	aBorder := self colorGrayBorder.

	[ aBorder paint: Color red ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].
	
	self assert: (anError isKindOf: BlImmutableObjectChangeError).
	
	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changeStyleError [
	<gtExample>
	| aBorder anError |

	aBorder := self colorGrayBorder.

	[ aBorder style: BlStrokeStyle default ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].
	
	self assert: (anError isKindOf: BlImmutableObjectChangeError).
	
	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changeWidthError [
	<gtExample>
	| aBorder anError |

	aBorder := self colorGrayBorder.

	[ aBorder width: 20 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].
	
	self assert: (anError isKindOf: BlImmutableObjectChangeError).
	
	^ anError
]

{ #category : #'examples - color' }
BlBorderExamples >> colorGrayBorder [
	<gtExample>
	| aBorder |

	aBorder := BlBorder paint: Color gray.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #'examples - color' }
BlBorderExamples >> colorGrayBorderWithExplicitWidth [
	<gtExample>
	| aBorder |

	aBorder := BlBorder paint: Color gray width: 10.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 10.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]
