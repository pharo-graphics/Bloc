Class {
	#name : #BlSpartaFileImageElement,
	#superclass : #BlSpartaImageElement,
	#instVars : [
		'file'
	],
	#category : #'Bloc-Sparta-Elements'
}

{ #category : #accessing }
BlSpartaFileImageElement class >> file: aFileName [

	^ self new file: aFileName
]

{ #category : #accessing }
BlSpartaFileImageElement >> file [
	^ file
]

{ #category : #accessing }
BlSpartaFileImageElement >> file: aFileReference [

	file := aFileReference asFileReference 
]

{ #category : #private }
BlSpartaFileImageElement >> getImageWith: aCanvas [
	"Get the appropriate back-end specific image to display"

	^ [ aCanvas bitmap fromFile: file ]
		on: Error 
		do: [ :ex | self exception: ex ]
]
