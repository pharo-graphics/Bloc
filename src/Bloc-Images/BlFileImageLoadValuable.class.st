"
BlFileImageLoadValuable is responsible for loading a single image from disk by passing the request on to ${method:name=BlLocalImageCache class>>#current}$.  

"
Class {
	#name : #BlFileImageLoadValuable,
	#superclass : #BlAsyncImageLoadValuable,
	#instVars : [
		'file'
	],
	#category : #'Bloc-Images-TaskIt'
}

{ #category : #'instance creation' }
BlFileImageLoadValuable class >> file: aFileReference element: aBlElement [

	^self new initializeFile: aFileReference element: aBlElement
]

{ #category : #initialization }
BlFileImageLoadValuable >> initializeFile: aFileReference element: aBlElement [

	self initialize.
	file := aFileReference asFileReference.
	element := aBlElement
]

{ #category : #private }
BlFileImageLoadValuable >> updateElement [
	"Ask the cache to update the receiver's element"

	^BlLocalImageCache current fileAt: file size: self cacheSize for: element

]
