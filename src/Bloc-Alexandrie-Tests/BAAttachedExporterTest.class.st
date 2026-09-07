Class {
	#name : #BAAttachedExporterTest,
	#superclass : #BAAbstractExporterTest,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Alexandrie-Tests-Exporter'
}

{ #category : #running }
BAAttachedExporterTest >> prepareElementToExport: anElement [

	space root addChild: anElement.
	space settle.
	^ anElement
]

{ #category : #running }
BAAttachedExporterTest >> setUp [

	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: element.
	space show; settle
]

{ #category : #running }
BAAttachedExporterTest >> tearDown [

	space ifNotNil: [
		space close; settle.
		space := nil ].
	super tearDown
]

{ #category : #tests }
BAAttachedExporterTest >> testAeAsFormFromHostPulseProcess [

	| form |
	space deferAndSettle: [ form := element aeAsForm ].
	self assert: form isNotNil.
	self assert: form extent equals: 100 @ 50
]

{ #category : #tests }
BAAttachedExporterTest >> testAeAsFormWithPendingLayoutFromHostPulseProcessErrors [

	| raisedError |
	raisedError := false.
	space deferAndSettle: [
		element requestLayout.
		self should: [ element aeAsForm ] raise: Error.
		raisedError := true ].
	self assert: raisedError
]

{ #category : #tests }
BAAttachedExporterTest >> testExportFromHostPulseProcess [

	| form |
	space deferAndSettle: [ form := element exportAsForm ].
	self assert: form isNotNil.
	self assert: form extent equals: 100 @ 50
]

{ #category : #tests }
BAAttachedExporterTest >> testExportWithPendingLayoutFromHostPulseProcessErrors [

	| raisedError |
	raisedError := false.
	space deferAndSettle: [
		element requestLayout.
		self should: [ element exportAsForm ] raise: Error.
		raisedError := true ].
	self assert: raisedError
]
