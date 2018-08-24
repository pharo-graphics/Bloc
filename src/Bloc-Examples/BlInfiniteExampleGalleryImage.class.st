Class {
	#name : #BlInfiniteExampleGalleryImage,
	#superclass : #Object,
	#instVars : [
		'format',
		'filename',
		'author',
		'authorUrl',
		'height',
		'width',
		'postUrl',
		'id',
		'form'
	],
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #'instance creation' }
BlInfiniteExampleGalleryImage class >> fromDictionary: aDictionary [
	^ self new
		format: (aDictionary at: #format);
		filename: (aDictionary at: #filename);
		author: (aDictionary at: #author);
		authorUrl: (aDictionary at: #author_url);
		height: (aDictionary at: #height);
		postUrl: (aDictionary at: #post_url);
		id: (aDictionary at: #id);
		width: (aDictionary at: #width);
		yourself
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> author [
	^ author
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> author: anObject [
	author := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> authorUrl [
	^ authorUrl
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> filename [
	^ filename
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> form [
	^ form
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> form: aForm [
	form := aForm
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> format [
	^ format
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> format: anObject [
	format := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> height [
	^ height
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> height: anObject [
	height := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> id [
	^ id
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> id: anObject [
	id := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> loadUrl: anExtent [
	^ 'https://unsplash.it/', (anExtent x min: 4096) asString, '/', (anExtent y min: 4096) asString,'?image=', self id asString
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> postUrl [
	^ postUrl
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> postUrl: anObject [
	postUrl := anObject
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> width [
	^ width
]

{ #category : #accessing }
BlInfiniteExampleGalleryImage >> width: anObject [
	width := anObject
]
