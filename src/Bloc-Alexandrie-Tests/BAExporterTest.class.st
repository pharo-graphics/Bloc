Class {
	#name : #BAExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'testDirectory'
	],
	#category : #'Bloc-Alexandrie-Tests-Exporter'
}

{ #category : #running }
BAExporterTest >> newContainerWithChild [

	| child container |
	child := BlElement new
		extent: 40 @ 20;
		background: Color blue;
		yourself.
	container := BlElement new
		extent: 100 @ 50;
		background: Color transparent;
		addChild: child;
		yourself.
	^ container
]

{ #category : #running }
BAExporterTest >> newTestElement [

	^ BlElement new
		extent: 100 @ 50;
		background: Color red;
		yourself
]

{ #category : #running }
BAExporterTest >> setUp [

	super setUp.
	testDirectory := (FileLocator temp / ('bloc-export-tests-' , UUID new asString36)) ensureCreateDirectory
]

{ #category : #running }
BAExporterTest >> tearDown [

	testDirectory ifNotNil: [
		testDirectory ensureDeleteAll.
		testDirectory := nil ].
	super tearDown
]

{ #category : #tests }
BAExporterTest >> testBARendererWriteAsPngTo [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile |
		targetFile := testDirectory / ('renderer-write-' , anElement isAttachedToSceneGraph asString , '.png').
		BARenderer write: anElement asPngTo: targetFile.
		self assert: targetFile exists.
		self assert: targetFile size > 0 ]
]

{ #category : #tests }
BAExporterTest >> testExportAsForm [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| form |
		form := anElement exportAsForm.
		self assert: (form isKindOf: Form).
		self assert: form extent equals: 100 @ 50.
		self assert: form depth equals: 32.
		self assert: (form colorAt: 50 @ 25) equals: Color red ]
]

{ #category : #tests }
BAExporterTest >> testExportAsFormWithCustomBackground [

	self withCustomElementAttachedAndDetached: [ self newContainerWithChild ] do: [ :container |
		| form |
		form := BAExporter form
			element: container;
			background: Color yellow;
			export.
		self assert: (form colorAt: 20 @ 10) equals: Color blue.
		self assert: (form colorAt: 80 @ 40) equals: Color yellow ]
]

{ #category : #tests }
BAExporterTest >> testExportAsFormWithScale [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| form |
		form := BAExporter form
			element: anElement;
			scale: 2.0;
			export.
		self assert: form extent equals: 200 @ 100 ]
]

{ #category : #tests }
BAExporterTest >> testExportAsJPEG [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile result readForm |
		targetFile := testDirectory / ('test-' , anElement isAttachedToSceneGraph asString , '.jpg').
		result := BAExporter jpg
			element: anElement;
			target: targetFile;
			export.
		self assert: result equals: targetFile.
		self assert: targetFile exists.
		self assert: targetFile size > 0.
		self assert: (targetFile binaryReadStreamDo: [ :stream | stream next: 3 ]) equals: #[16rFF 16rD8 16rFF].
		readForm := ImageReadWriter formFromFileNamed: targetFile fullName.
		self assert: readForm extent equals: 100 @ 50 ]
]

{ #category : #tests }
BAExporterTest >> testExportAsJPEGQualityAndProgressive [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile |
		targetFile := testDirectory / ('quality-' , anElement isAttachedToSceneGraph asString , '.jpg').
		BAExporter jpg
			element: anElement;
			target: targetFile;
			quality: 50;
			isProgressive: false;
			export.
		self assert: targetFile exists.
		self assert: targetFile size > 0 ]
]

{ #category : #tests }
BAExporterTest >> testExportAsPDF [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile result header |
		targetFile := testDirectory / ('test-' , anElement isAttachedToSceneGraph asString , '.pdf').
		result := BAExporter pdf
			element: anElement;
			target: targetFile;
			export.
		self assert: result equals: targetFile.
		self assert: targetFile exists.
		self assert: targetFile size > 0.
		header := targetFile binaryReadStreamDo: [ :stream | (stream next: 4) asString ].
		self assert: header equals: '%PDF' ]
]

{ #category : #tests }
BAExporterTest >> testExportAsPNG [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile result readForm |
		targetFile := testDirectory / ('test-' , anElement isAttachedToSceneGraph asString , '.png').
		result := BAExporter png
			element: anElement;
			target: targetFile;
			export.
		self assert: result equals: targetFile.
		self assert: targetFile exists.
		self assert: targetFile size > 0.
		self assert: (targetFile binaryReadStreamDo: [ :stream | stream next: 4 ]) equals: #[16r89 16r50 16r4E 16r47].
		readForm := ImageReadWriter formFromFileNamed: targetFile fullName.
		self assert: readForm extent equals: 100 @ 50 ]
]

{ #category : #tests }
BAExporterTest >> testExportAsSVG [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| targetFile result contents |
		targetFile := testDirectory / ('test-' , anElement isAttachedToSceneGraph asString , '.svg').
		result := BAExporter svg
			element: anElement;
			target: targetFile;
			export.
		self assert: result equals: targetFile.
		self assert: targetFile exists.
		self assert: targetFile size > 0.
		contents := targetFile readStreamDo: [ :stream | stream contents ].
		self assert: (contents includesSubstring: '<svg') ]
]

{ #category : #tests }
BAExporterTest >> testExportFromForkedProcess [

	self withElementAttachedAndDetachedDo: [ :anElement |
		| sem form |
		sem := Semaphore new.
		[ form := anElement exportAsForm. sem signal ] fork.
		sem waitTimeoutMilliseconds: 2000.
		self assert: form isNotNil.
		self assert: form extent equals: 100 @ 50 ]
]

{ #category : #tests }
BAExporterTest >> testExportFromHostUIProcess [

	| space form |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: self newTestElement.
	space show; settle.
	space defer: [ form := space root children first exportAsForm ].
	space settle.
	self assert: form isNotNil.
	self assert: form extent equals: 100 @ 50.

	space close; settle
]

{ #category : #tests }
BAExporterTest >> testExportMultipleConcurrentForkedProcesses [

	| forms mutex sem count |
	forms := OrderedCollection new.
	mutex := Mutex new.
	sem := Semaphore new.
	count := 5.
	1 to: count do: [ :i |
		[	| f |
			f := (BlElement new
				extent: (30 * i) @ (20 * i);
				background: Color blue) exportAsForm.
			mutex critical: [ forms add: f ].
			sem signal ] fork ].
	count timesRepeat: [ sem waitTimeoutMilliseconds: 3000 ].
	self assert: forms size equals: count
]

{ #category : #tests }
BAExporterTest >> testExportUnattachedElementRequiringLayout [

	| container child form |
	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 10);
		yourself.
	child := BlElement new
		extent: 40 @ 30;
		background: Color green;
		yourself.
	container addChild: child.
	form := container exportAsForm.
	self assert: form extent equals: 60 @ 50
]

{ #category : #tests }
BAExporterTest >> testExportUnattachedFromHostUIProcess [

	| space form |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space show; settle.
	space defer: [
		| unattached |
		unattached := BlElement new
			extent: 80 @ 40;
			background: Color yellow;
			requestLayout;
			yourself.
		form := unattached exportAsForm ].
	space settle.
	self assert: form isNotNil.
	self assert: form extent equals: 80 @ 40.

	space close; settle
]

{ #category : #running }
BAExporterTest >> withCustomElementAttachedAndDetached: anElementValuable do: aBlock [

	| unattachedElement attachedElement space |
	unattachedElement := anElementValuable value.
	aBlock value: unattachedElement.

	attachedElement := anElementValuable value.
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: attachedElement.
	[
		space show; settle.
		aBlock value: attachedElement
	] ensure: [
		space close; settle ]
]

{ #category : #running }
BAExporterTest >> withElementAttachedAndDetachedDo: aBlock [

	self withCustomElementAttachedAndDetached: [ self newTestElement ] do: aBlock
]
