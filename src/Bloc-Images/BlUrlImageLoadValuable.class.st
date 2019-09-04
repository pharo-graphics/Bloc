"
BlUrlImageLoadValuable is responsible for loading a single image at the supplied URL.  This is done by passing the request on to ${method:name=BlLocalImageCache class>>#current}$.  

"
Class {
	#name : #BlUrlImageLoadValuable,
	#superclass : #BlAsyncElementValuable,
	#instVars : [
		'url'
	],
	#category : #'Bloc-Images-TaskIt'
}

{ #category : #'instance creation' }
BlUrlImageLoadValuable class >> url: aZnUrl element: aBlElement [

	^self new initializeUrl: aZnUrl element: aBlElement
]

{ #category : #initialization }
BlUrlImageLoadValuable >> initializeUrl: aZnUrl element: aBlElement [

	self initialize.
	url := aZnUrl asZnUrl.
	element := aBlElement
]

{ #category : #private }
BlUrlImageLoadValuable >> updateElement [
	"Ask the cache to update the receiver's element"

	^BlWorkerImageCache current url: url size: self extent max for: element

]
