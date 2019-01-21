"
I export bloc element to a file.
See my subclasses for different output formats
"
Class {
	#name : #BlFileExporter,
	#superclass : #BlExporter,
	#instVars : [
		'fileName'
	],
	#category : 'Bloc-Exporter'
}

{ #category : #private }
BlFileExporter >> askFileName [
	^ UIManager default 
		chooseForSaveFileReference: 'Save Element as ', self extension asUppercase 
		extensions: { self extension } 
		path: Smalltalk imageDirectory / (self element class name, '-', self element hash asString,'.' , self extension)
]

{ #category : #'api - exporting' }
BlFileExporter >> extension [
	"Return a default file extension to be used during export"
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlFileExporter >> fileName [
	^ fileName ifNil: [ fileName := self askFileName ]
]

{ #category : #'api - configuration' }
BlFileExporter >> fileName: aString [
	fileName := aString
]
