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
BlImageCache >> answerForm: aForm size: aSize isOriginal: isOriginal [

	^BlImageCacheEntry new
		isSmallest: (aSize <= imageSizes first);
		isOriginal: isOriginal;
		form: aForm;
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
	"Answer the default cache sizes to use, i.e.
	#(200, <in the middle>, <Display max dimension>)"

	| newImageSizes newSize |

	"Start with the larger dimension of the display and divide by 4 down to 200"
	newSize := Display width max: Display height.
	newImageSizes := Array new: 3.
	newImageSizes
		at: 1 put: 200;
		at: 2 put: (newSize // 2);
		at: 3 put: newSize.
	^newImageSizes
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

{ #category : #private }
BlImageCache >> formFor: aFileReference [
	"Answer the form in the specified file"

	^ImageReadWriter gtFormFromBuffer: (self getBufferFor: aFileReference).
]

{ #category : #private }
BlImageCache >> getBufferFor: aFileReference [
	"Answer the contents of the specified file in a ByteArray.
	While this method is synchronous, file access is async"

	| file asyncFile fileSemaphore buffer |

	file := aFileReference asFileReference.
	asyncFile := AsyncFile new.
	fileSemaphore := Semaphore new.
	(asyncFile open: file pathString forWrite: false) ifNil: 
		[ ^file binaryReadStreamDo: [ :stream | stream upToEnd ] ].
	[ asyncFile readByteCount: file size fromFilePosition: 0 onCompletionDo: 
		[ :buf | buffer := buf.  fileSemaphore signal ].
        fileSemaphore wait. ] ensure: [ asyncFile close ].
	"Hack to work around AsyncFile returning a string instead of a ByteArray"
	ByteArray adoptInstance: buffer.
	^buffer
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
BlImageCache >> set: anObject form: aForm size: anInteger isOriginal: aBoolean [
	"Set the entry in anObject with the supplied information"

	^anObject entry: (self answerForm: aForm size: anInteger isOriginal: aBoolean)
]

{ #category : #accessing }
BlImageCache >> totalAccesses [

	^hits + misses
]
