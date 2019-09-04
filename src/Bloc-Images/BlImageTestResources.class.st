Class {
	#name : #BlImageTestResources,
	#superclass : #TestResource,
	#instVars : [
		'testDirectory',
		'forms',
		'f1',
		'f2',
		'f3'
	],
	#category : #'Bloc-Images-Tests'
}

{ #category : #accessing }
BlImageTestResources >> f1 [
	^ f1
]

{ #category : #accessing }
BlImageTestResources >> f2 [
	^ f2
]

{ #category : #accessing }
BlImageTestResources >> f3 [
	^ f3
]

{ #category : #accessing }
BlImageTestResources >> forms [
	^ forms
]

{ #category : #running }
BlImageTestResources >> setUp [ 

	| images |
	super setUp.
	testDirectory := FileReference newTempFilePrefix: 'Gtoolkit-Images-' suffix: '-tests'.
	testDirectory ensureCreateDirectory.
	images := testDirectory / 'images'.
	images ensureCreateDirectory.
	forms := { 
		Smalltalk ui icons iconNamed: 'arrowUp'.
		Smalltalk ui icons iconNamed: 'arrowDown'.
		Smalltalk ui icons iconNamed: 'back'.
		 }.
	f1 := images / 'f1.jpg'.
	PluginBasedJPEGReadWriter 
		putForm: forms first
		onFileNamed: f1.
	f2 := images / 'f2.jpg'.
	PluginBasedJPEGReadWriter 
		putForm: forms second
		onFileNamed: f2.
	f3 := images / 'f3.jpg'.
	PluginBasedJPEGReadWriter 
		putForm: forms third
		onFileNamed: f3.

]

{ #category : #running }
BlImageTestResources >> tearDown [ 

	testDirectory ensureDeleteAll.
	super tearDown.

]

{ #category : #running }
BlImageTestResources >> tempFile [

	| images tempFile |

	images := testDirectory / 'images'.
	tempFile := images / 'tempF1.jpg'.
	PluginBasedJPEGReadWriter 
		putForm: forms first
		onFileNamed: tempFile.
	^tempFile
]

{ #category : #accessing }
BlImageTestResources >> testDirectory [
	^ testDirectory
]
