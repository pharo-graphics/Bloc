Class {
	#name : #BADetachedExporterTest,
	#superclass : #BAAbstractExporterTest,
	#category : #'Bloc-Alexandrie-Tests-Exporter'
}

{ #category : #tests }
BADetachedExporterTest >> testExportUnattachedElementRequiringLayout [

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
BADetachedExporterTest >> testExportUnattachedFromHostUIProcess [

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
