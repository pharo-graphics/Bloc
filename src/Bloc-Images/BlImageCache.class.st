"
BlImageCache is an abstract super-class of the various image caches.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #BlImageCache,
	#superclass : #Object,
	#instVars : [
		'maxCacheSize',
		'imageSizes',
		'hits',
		'misses'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #private }
BlImageCache >> answerImage: aForm size: aSize isOriginal: isOriginal [

	^BlImageCacheEntry new
		isSmallest: (aSize <= imageSizes first);
		isOriginal: isOriginal;
		image: aForm;
		yourself
]

{ #category : #private }
BlImageCache >> cacheSizeFor: minImageSize [
	"Answer the cached image size just larger than minImageSize"

	minImageSize ifNil: [ ^nil ].
	^imageSizes detect: [ :size | minImageSize <= size ]
							ifNone: [ nil ].
	
]

{ #category : #manage }
BlImageCache >> clearStats [

	hits := misses := 0.
]

{ #category : #private }
BlImageCache >> defaultImageSizes [
	"Answer the default cache sizes to use"

	^ #(300 600 1280 2560)
]

{ #category : #accessing }
BlImageCache >> fileAt: aFileReference size: minImageSize [
	"Answer the BlImageCacheEntry for the specified file and requested size.
	If minImageSize isNil, answer the form from the original file.
	Otherwise answer the cached image which is larger than minImageSize."

	^self subclassResponsibility 
]

{ #category : #accessing }
BlImageCache >> fileAt: aFileReference size: minImageSize for: anObject [
	"Set the #entry: in anObject for the specified file and requested size.
	If minImageSize isNil, set the form from the original file.
	Otherwise set the cached image which is larger than minImageSize."

	^anObject entry: (self fileAt: aFileReference size: minImageSize)
]

{ #category : #accessing }
BlImageCache >> flush [ 
	"Empty the receiver cache"

	^self subclassResponsibility 
]

{ #category : #accessing }
BlImageCache >> hitRate [
	"Answer the receiver's hit rate"

	| totalAccesses |

	totalAccesses := self totalAccesses.
	^totalAccesses = 0
		ifTrue: [ 0 ]
		ifFalse: [ hits asFloat / totalAccesses asFloat ]
]

{ #category : #accessing }
BlImageCache >> hits [
	^ hits
]

{ #category : #private }
BlImageCache >> imageFor: aFileReference [
	"Answer the image in the specified file"

	^ [ SkiaImage fromFile: aFileReference asAbsolute pathString ] 
		on: Error 
		do: [ SkiaImage fromForm: (ImageReadWriter gtFormFromFileReference: aFileReference) ].
]

{ #category : #accessing }
BlImageCache >> imageSizes [
	^ imageSizes
]

{ #category : #configuration }
BlImageCache >> imageSizes: anArray [
	"Set the image sizes to cache.
	The longer dimension of the image will be the size specified."

	imageSizes := anArray sorted.
]

{ #category : #initialization }
BlImageCache >> initialize [

	super initialize.
	self imageSizes: self defaultImageSizes.
	hits := 0.
	misses := 0.
]

{ #category : #accessing }
BlImageCache >> maxCacheSize [ 

	^maxCacheSize 
]

{ #category : #configuration }
BlImageCache >> maxCacheSize: anInteger [

	maxCacheSize := anInteger
]

{ #category : #accessing }
BlImageCache >> misses [
	^ misses
]

{ #category : #private }
BlImageCache >> set: anObject image: anImage size: anInteger isOriginal: aBoolean [
	"Set the entry in anObject with the supplied information"

	^anObject entry: (self answerImage: anImage size: anInteger isOriginal: aBoolean)
]

{ #category : #accessing }
BlImageCache >> totalAccesses [

	^hits + misses
]
