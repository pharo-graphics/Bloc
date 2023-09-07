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

{ #category : #accessing }
BlFileExporter >> extension [
	"Return a String representing default file extension to be used during export"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlFileExporter >> fileName: aFileReference [

	self
		deprecated: 'Use target: instead'
		transformWith: '`@receiver fileName: `@argument'
			-> '`@receiver target: `@argument'.

	self target: aFileReference
]

{ #category : #private }
BlFileExporter >> finishExport: aeCanvas [

	^ target
]

{ #category : #accessing }
BlFileExporter >> target [

	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #accessing }
BlFileExporter >> target: aFileReference [

	target := aFileReference
]
