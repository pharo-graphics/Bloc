"
BlMemoryImageCache provides a cache of file system and network images at specified sizes.

- The cache is stored in memory.
- Cache entries are created lazily, i.e. only when a cache entry of the specified size is requested.
- If the original image size is smaller than the cache size, the original will be returned (i.e. images are never extended, only shrunk).

!!Public API and Key Messages

- maxCacheSize: 	Set the number of entries held in memory.  See #initialize for the default.

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	cache:			<Array of Association>
	cacheIndex:		<Object>


!!!Implementation Points

The cache is expected to be fairly small, e.g. 5 - 10 entries.  If a large cache is desired BlLocalImageCache will normally be used instead.

Since the cache is small, a simple array is used instead of a dictionary.  Possibly SmallDictionary should be used instead.
"
Class {
	#name : #BlMemoryImageCache,
	#superclass : #BlImageCache,
	#instVars : [
		'cache',
		'cacheIndex'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #private }
BlMemoryImageCache >> cacheFileFor: aFileReference size: cacheSize [
	"Answer the file name used to cache aFileReference at cacheSize"

	^(aFileReference / cacheSize printString) pathString.

]

{ #category : #private }
BlMemoryImageCache >> cacheFileForUrl: znUrl size: cacheSize [

	^String streamContents: [ :stream |
		stream
			print: znUrl;
			<< '/';
			print: cacheSize ].

]

{ #category : #public }
BlMemoryImageCache >> cacheSize [ 
	"Answer the current cache size"

	^cache size
]

{ #category : #accessing }
BlMemoryImageCache >> entryAt: cacheKey [
	"Answer the entry at the supplied key, nil if none"

	^cache
		detect: [ :each | each key = cacheKey ]
		ifFound: [ :assoc | assoc value ]
		ifNone: [ nil ]
]

{ #category : #accessing }
BlMemoryImageCache >> entryAt: cacheKey put: aBlImageCacheEntry [
	"Set the entry at the supplied key"

	cacheIndex := cacheIndex >= cache size
		ifTrue: [ 1 ]
		ifFalse: [ cacheIndex + 1 ].
	^cache at: cacheIndex put: cacheKey -> aBlImageCacheEntry.

]

{ #category : #accessing }
BlMemoryImageCache >> fileAt: aFileReference size: minImageSize [
	"Answer the BlImageCacheEntry for the specified file and requested size.
	If minImageSize isNil, answer the form from the original file.
	Otherwise answer the cached image which is larger than minImageSize."

	| fileReference cacheSize cacheKey cacheEntry image |

	fileReference := aFileReference asFileReference.
	cacheSize := self cacheSizeFor: minImageSize.
	(minImageSize isNil or: [ cacheSize isNil ]) ifTrue: [ 
		image := self imageFor: fileReference.
		^self answerImage: image size: image extent max isOriginal: true ].

	cacheKey := self cacheFileFor: fileReference size: cacheSize.
	(self entryAt: cacheKey) ifNotNil: [ :entry | 
		hits := hits + 1.
		^entry ].

	image := self imageFor: fileReference.
	misses := misses + 1.
	cacheSize >= image extent max ifTrue: 
		[ ^self answerImage: image size: image extent max isOriginal: true ].
	image := image scalex: cacheSize y: cacheSize keepAspectRatio: true quality: SkiaFilterQuality High.
	cacheEntry := self answerImage: image size: cacheSize isOriginal: false.
	self entryAt: cacheKey put: cacheEntry.
	^cacheEntry.

]

{ #category : #accessing }
BlMemoryImageCache >> flush [ 
	"Empty the receiver cache"

	"The cache is initialised while setting the max cache size"
	self maxCacheSize: maxCacheSize
]

{ #category : #initialization }
BlMemoryImageCache >> initialize [ 

	super initialize.
	self maxCacheSize: 5.
]

{ #category : #configuration }
BlMemoryImageCache >> maxCacheSize: anInteger [

	super maxCacheSize: anInteger.
	cache := Array new: maxCacheSize withAll: nil -> nil.
	cacheIndex := 0.
]

{ #category : #'system startup' }
BlMemoryImageCache >> shutDown: quitting [
	"Flush the cache on session shutdown so random images aren't bloating the image and left on disk"
	
	self flush
]

{ #category : #'accessing - cache' }
BlMemoryImageCache >> url: aUrl size: minImageSize for: anObject [
	"Answer the Form for the specified URL and requested size.
	If minImageSize isNil, answer the form from the original file.
	Otherwise answer the cached image which is larger than minImageSize."

	| znUrl content cacheSize cacheKey cacheEntry image originalSize |

	znUrl := aUrl asZnUrl.
	"If the appropriate cache entry already exists, just return it.
	Otherwise look for the original. If that doesn't exist, download it."
	minImageSize ifNotNil: [ 
		cacheSize := self cacheSizeFor: minImageSize.
		cacheKey := self cacheFileForUrl: znUrl size: cacheSize.
		(self entryAt: cacheKey) ifNotNil: [ :entry | 
			hits := hits + 1.
			^anObject entry: entry ] ].

	"The cache entry doesn't exist or the original has been requested"
	cacheKey := self cacheFileForUrl: znUrl size: nil.
	"Ensure we have the original in cache"
	cacheEntry := self entryAt: cacheKey.
	cacheEntry ifNil:
		"Workaround for ZnEasy not being completely general
		(it doesn't handle #file scheme)"
		[ content := znUrl scheme = #file
				ifFalse: [ (ZnEasy get: znUrl) entity bytes ]
				ifTrue: [ znUrl asFileReference gtBinaryContents ].
		misses := misses + 1.
		image := SkiaImage fromForm: (ImageReadWriter formFromStream: content readStream).
		originalSize := image extent max.
		cacheEntry := self answerImage: image size: originalSize isOriginal: true.
		self entryAt: cacheKey put: cacheEntry ]
	ifNotNil: 
		[ image := cacheEntry image.
		originalSize := image extent max ].

	minImageSize ifNil: [ ^anObject entry: cacheEntry ].

	"If the requested cache size is larger than the original, just return the original"
	cacheSize >= originalSize ifTrue: [ ^anObject entry: cacheEntry ].

	"Answer the form scaled to cacheSize"
	image := image scalex: cacheSize y: cacheSize keepAspectRatio: true quality: SkiaFilterQuality High.
	cacheEntry := self answerImage: image size: cacheSize isOriginal: false.
	misses := misses + 1.
	^anObject entry: cacheEntry.

]
