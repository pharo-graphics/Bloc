Class {
	#name : #BlBenchmarkLogger,
	#superclass : #BlElement,
	#classInstVars : [
		'benchmarks'
	],
	#category : 'Bloc-DevTool-Core'
}

{ #category : #benchmark }
BlBenchmarkLogger class >> benchmarks [

	^ benchmarks ifNil: [ benchmarks := Dictionary new ]
]

{ #category : #cleanup }
BlBenchmarkLogger class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	benchmarks := nil
]

{ #category : #benchmark }
BlBenchmarkLogger class >> named: aSymbol on: aBlock [
	| start end coefficient duration |

	start := Time microsecondClockValue.
	aBlock value.
	end := Time microsecondClockValue.
	
	coefficient := 0.1.
	
	duration := self benchmarks
		at: aSymbol
		ifPresent: [ :previous | previous + (((end - start) - previous) * coefficient) ]
		ifAbsent: [ end - start ].
		
	self benchmarks
		at: aSymbol
		put: duration.
	
	BlUniverse default animationManager
		addAnimation: (BlTaskAction on: [ self allInstancesDo: #invalidate ])
]

{ #category : #drawing }
BlBenchmarkLogger >> drawOnSpartaCanvas: aCanvas [
	| benchmarkString text |
	super drawOnSpartaCanvas: aCanvas.
		
	aCanvas transform during: [ :aTransform |
		aTransform translateBy: 5@5.
		aTransform apply.
		
		benchmarkString := (String streamContents: [ :aStream |
		self class benchmarks keysAndValuesDo: [ :name :duration |
			aStream nextPutAll: name asString, ': ', ((duration / 1000.0) asFloat printShowingDecimalPlaces: 1), 'ms', String cr ] ]) trimmed.

		text := SpText fromString: benchmarkString.
		text attributes: { SpFontGenericFamilyAttribute monospace. SpTextBackgroundAttribute paint: (Color white alpha: 1) }.

		text drawOn: aCanvas.
	]
]

{ #category : #initialization }
BlBenchmarkLogger >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self border: (BlBorder paint: Color red width: 2).
	
	self preventMouseEvents
]
