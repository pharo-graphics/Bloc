"
I export a Bloc element to a file target.

See my subclasses for different output formats.
"
Class {
	#name : #BAFileExporter,
	#superclass : #BAExporter,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Alexandrie-Exporter'
}

{ #category : #private }
BAFileExporter >> defaultTarget [

	^ Smalltalk imageDirectory /
		(self element class name, '-', self element hash asString, '.' , self extension)
]

{ #category : #accessing }
BAFileExporter >> extension [
	"Return a String representing default file extension to be used during export"
	
	^ self subclassResponsibility
]

{ #category : #private }
BAFileExporter >> finishExport: aeCanvas [

	^ target
]

{ #category : #accessing }
BAFileExporter >> target [

	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #accessing }
BAFileExporter >> target: aFileReference [

	target := aFileReference
]
