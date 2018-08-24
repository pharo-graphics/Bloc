Class {
	#name : #BlInfiniteExampleGalleryDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'images',
		'loader'
	],
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteExampleGalleryDataSource >> images: anArray [
	images := anArray.

	"everything changed"
	self notifyChanged
]

{ #category : #initialization }
BlInfiniteExampleGalleryDataSource >> initialize [
	super initialize.
	
	images := #().
	hasStableIds := false
]

{ #category : #accessing }
BlInfiniteExampleGalleryDataSource >> itemCount [
	^ images size
]

{ #category : #'instance creation' }
BlInfiniteExampleGalleryDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder image: (images at: aPosition)
]

{ #category : #'instance creation' }
BlInfiniteExampleGalleryDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExampleGalleryElementHolder new
]

{ #category : #requesting }
BlInfiniteExampleGalleryDataSource >> requestImages [
	
	images
		ifNotEmpty: [ ^ self ].

	loader
		ifNotNil: [ ^ self ].

	loader := [
		| theImages |
		theImages := (STONJSON fromString: 'https://unsplash.it/list' asUrl retrieveContents)
			collect: [ :aDictionary | BlInfiniteExampleGalleryImage fromDictionary: aDictionary ].
		theImages sort: [ :a :b | a id > b id ].
		self images: theImages ] fork
]
