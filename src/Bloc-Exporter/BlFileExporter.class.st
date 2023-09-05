"
I export a Bloc element to a file target.

See my subclasses for different output formats.
"
Class {
	#name : #BlFileExporter,
	#superclass : #BlExporter,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #private }
BlFileExporter >> defaultTarget [

	^ Smalltalk imageDirectory /
		(self element class name, '-', self element hash asString, '.' , self extension)
]

{ #category : #'api - exporting' }
BlFileExporter >> extension [
	"Return a String representing default file extension to be used during export"
	
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
BlFileExporter >> fileName: aFileReference [

	self
		deprecated: 'Use target: instead'
		transformWith: '`@receiver fileName: `@argument'
			-> '`@receiver target: `@argument'.

	self target: aFileReference
]

{ #category : #accessing }
BlFileExporter >> target [

	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #'api - configuration' }
BlFileExporter >> target: aFileReference [

	target := aFileReference
]
