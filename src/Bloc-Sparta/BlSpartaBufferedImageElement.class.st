Class {
	#name : #BlSpartaBufferedImageElement,
	#superclass : #BlSpartaImageElement,
	#instVars : [
		'buffer'
	],
	#category : #'Bloc-Sparta-Elements'
}

{ #category : #accessing }
BlSpartaBufferedImageElement class >> buffer: aByteArray [

	^ self new buffer: aByteArray
]

{ #category : #accessing }
BlSpartaBufferedImageElement >> buffer [
	^ buffer
]

{ #category : #accessing }
BlSpartaBufferedImageElement >> buffer: aByteArray [
	"Set the receiver's buffer, an encoded image, e.g. jpg, png, bmp, etc.
	The supported formats will depend on the back-end being used"

	buffer := aByteArray
]

{ #category : #private }
BlSpartaBufferedImageElement >> getImageWith: aCanvas [
	"Get the appropriate back-end specific image to display"

	^ [ aCanvas bitmap fromBuffer: buffer ]
		on: Error 
		do: [ :ex | 
			self exception: ex.
			BlElement new. ]
]
