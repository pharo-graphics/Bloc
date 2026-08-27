Class {
	#name : #BAExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'testDirectory',
		'element'
	],
	#category : #'Bloc-Alexandrie-Tests-Exporter'
}

{ #category : #running }
BAExporterTest >> setUp [

	super setUp.
	testDirectory := (FileLocator temp / ('bloc-export-tests-' , UUID new asString36)) ensureCreateDirectory.
	element := BlElement new
		extent: 100 @ 50;
		background: Color red;
		yourself
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

	| targetFile |
	targetFile := testDirectory / 'renderer-write.png'.
	BARenderer write: element asPngTo: targetFile.
	self assert: targetFile exists.
	self assert: targetFile size > 0
]

{ #category : #tests }
BAExporterTest >> testExportAsForm [

	| form |
	form := element exportAsForm.
	self assert: (form isKindOf: Form).
	self assert: form extent equals: 100 @ 50.
	self assert: form depth equals: 32.
	self assert: (form colorAt: 50 @ 25) equals: Color red
]

{ #category : #tests }
BAExporterTest >> testExportAsFormWithCustomBackground [

	| child container form |
	child := BlElement new
		extent: 40 @ 20;
		background: Color blue;
		yourself.
	container := BlElement new
		extent: 100 @ 50;
		background: Color transparent;
		addChild: child;
		yourself.
	form := BAExporter form
		element: container;
		background: Color yellow;
		export.
	self assert: (form colorAt: 20 @ 10) equals: Color blue.
	self assert: (form colorAt: 80 @ 40) equals: Color yellow
]

{ #category : #tests }
BAExporterTest >> testExportAsFormWithScale [

	| form |
	form := BAExporter form
		element: element;
		scale: 2.0;
		export.
	self assert: form extent equals: 200 @ 100
]

{ #category : #tests }
BAExporterTest >> testExportAsJPEG [

	| targetFile result readForm |
	targetFile := testDirectory / 'test.jpg'.
	result := BAExporter jpg
		element: element;
		target: targetFile;
		export.
	self assert: result equals: targetFile.
	self assert: targetFile exists.
	self assert: targetFile size > 0.
	self assert: (targetFile binaryReadStreamDo: [ :stream | stream next: 3 ]) equals: #[16rFF 16rD8 16rFF].
	readForm := ImageReadWriter formFromFileNamed: targetFile fullName.
	self assert: readForm extent equals: 100 @ 50
]

{ #category : #tests }
BAExporterTest >> testExportAsJPEGQualityAndProgressive [

	| targetFile |
	targetFile := testDirectory / 'quality.jpg'.
	BAExporter jpg
		element: element;
		target: targetFile;
		quality: 50;
		isProgressive: false;
		export.
	self assert: targetFile exists.
	self assert: targetFile size > 0
]

{ #category : #tests }
BAExporterTest >> testExportAsPDF [

	| targetFile result header |
	targetFile := testDirectory / 'test.pdf'.
	result := BAExporter pdf
		element: element;
		target: targetFile;
		export.
	self assert: result equals: targetFile.
	self assert: targetFile exists.
	self assert: targetFile size > 0.
	header := targetFile binaryReadStreamDo: [ :stream | (stream next: 4) asString ].
	self assert: header equals: '%PDF'
]

{ #category : #tests }
BAExporterTest >> testExportAsPNG [

	| targetFile result readForm |
	targetFile := testDirectory / 'test.png'.
	result := BAExporter png
		element: element;
		target: targetFile;
		export.
	self assert: result equals: targetFile.
	self assert: targetFile exists.
	self assert: targetFile size > 0.
	self assert: (targetFile binaryReadStreamDo: [ :stream | stream next: 4 ]) equals: #[16r89 16r50 16r4E 16r47].
	readForm := ImageReadWriter formFromFileNamed: targetFile fullName.
	self assert: readForm extent equals: 100 @ 50
]

{ #category : #tests }
BAExporterTest >> testExportAsSVG [

	| targetFile result contents |
	targetFile := testDirectory / 'test.svg'.
	result := BAExporter svg
		element: element;
		target: targetFile;
		export.
	self assert: result equals: targetFile.
	self assert: targetFile exists.
	self assert: targetFile size > 0.
	contents := targetFile readStreamDo: [ :stream | stream contents ].
	self assert: (contents includesSubstring: '<svg')
]

{ #category : #tests }
BAExporterTest >> testExportAttachedElementInSpace [

	| space form |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: element.
	space show; settle.
	form := element exportAsForm.
	self assert: form extent equals: 100 @ 50.
	self assert: (form colorAt: 50 @ 25) equals: Color red.

	space close; settle
]

{ #category : #tests }
BAExporterTest >> testExportFromForkedProcess [

	| sem form |
	sem := Semaphore new.
	[ form := element exportAsForm. sem signal ] fork.
	sem waitTimeoutMilliseconds: 2000.
	self assert: form isNotNil.
	self assert: form extent equals: 100 @ 50
]

{ #category : #tests }
BAExporterTest >> testExportFromHostUIProcess [

	| space form |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: element.
	space show; settle.
	space defer: [ form := element exportAsForm ].
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
