"
BlLocalImageCache provides a cache of file system and network images at specified sizes.

- The cache is stored on disk.
- Cache entries are created lazily, i.e. only when a cache entry of the specified size is requested.
- If the original image size is smaller than the cache size, the original will be returned.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cacheRoot:		<FileReference>
	fileRoot:		<FileReference>
	imageSizes:		<Array>
	maxCacheSize:		<Integer>  The maximum size of the cache in bytes.  The actual size may grow somewhat larger than specified in a busy system.
	networkRoot:		<FileReference>
	housekeeper:		<BlImageCacheHousekeeper>
	hits:								<Integer>
	misses:						<Integer>


!!!Implementation Points

To allow lookup in the file system cache to be quick either an index has to be held in memory or the cache entries found quickly.

The current assumption is that the memory cost of an in-memory index is too high.

Scanning a directory looking for files is slow - Pharo always walks over all the files in the directory and matches the file name.  Determining whether a given file exists is fast, a single plugin primitive call.

So we want the cache structure to allow lookup to be determined on the basis of a known file / directory existing or not.  The chosen structure is:

	fileRoot / <path to image> / <image file name> / <cache entry name>.jpg

The directory containing the cache entries can then easily be tested for existence.

To maximise the cache speed, no attempt is made to the cache thread safe.  The side affect is that the cache sizes are approximate and that the cache may actually grow larger than the specified constraints in a busy system.
"
Class {
	#name : #BlLocalImageCache,
	#superclass : #BlImageCache,
	#instVars : [
		'cacheRoot',
		'fileRoot',
		'networkRoot',
		'taskitRunner',
		'housekeeper'
	],
	#classVars : [
		'Current'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #accessing }
BlLocalImageCache class >> current [ 

	^Current ifNil: [ self default. Current ]
]

{ #category : #accessing }
BlLocalImageCache class >> default [ 
	
	self useMemoryImageCache.


	"Answer the default instance to use.
	If worker images are available, they will be used, otherwise everything will be done in-image"
"	^(Smalltalk hasClassNamed: #BlTlpWorkerPool)
		ifTrue: [ BlWorkerImageCache new ]
		ifFalse: [ BlLocalImageCache new ]"
]

{ #category : #'class initialization' }
BlLocalImageCache class >> initialize [

	SessionManager default
		registerUserClassNamed: self name.
]

{ #category : #'system startup' }
BlLocalImageCache class >> shutDown: quitting [
	"Give the current cache the chance to shutdown"

	Current ifNotNil: [ Current shutDown: quitting ]
]

{ #category : #managing }
BlLocalImageCache class >> stopCurrent [
	<script>
	"Flush the default image cache and clear the pointer.
	Note that this currently leaves 3 directories behind if the cache is on-disk"

	Current ifNil: [ ^self ].
	Current flush.
	Current := nil.
]

{ #category : #managing }
BlLocalImageCache class >> useLocalImageCache [
	"Force the use of BlLocalImageCache"
	<script>

	self stopCurrent.
	Current := BlLocalImageCache new setDefaultLocation.
]

{ #category : #managing }
BlLocalImageCache class >> useMemoryImageCache [
	"Force the use of BlMemoryImageCache"
	<script>

	self stopCurrent.
	Current := BlMemoryImageCache new.
]

{ #category : #private }
BlLocalImageCache >> cacheFileFor: aFileReference size: cacheSize [
	"Answer the file name used to cache aFileReference at cacheSize"

	| cacheFile |

	cacheFile := fileRoot.
	aFileReference path segments do: 
		[ :each | cacheFile := cacheFile / each ].
	cacheFile := cacheFile / (cacheSize printString, '.jpg').
	^cacheFile
]

{ #category : #private }
BlLocalImageCache >> cacheFileForUrl: znUrl size: cacheSize [

	| fileReference hash |

	hash := (SHA256 new hashStream: znUrl asString readStream) hex.
	fileReference := networkRoot / hash / (cacheSize
		ifNil: [ 'original.image' ]
		ifNotNil: [ cacheSize asString, '.jpg' ]).
	^fileReference
]

{ #category : #private }
BlLocalImageCache >> cacheRoot [ 

	^cacheRoot
]

{ #category : #configuration }
BlLocalImageCache >> cacheRoot: aFileReference [

	cacheRoot := aFileReference asFileReference.
	self ensureCreateDirectory: cacheRoot.
	fileRoot := cacheRoot / 'files'.
	self ensureCreateDirectory: fileRoot.
	networkRoot := cacheRoot / 'network'.
	self ensureCreateDirectory: networkRoot.
	self initHousekeeping.
]

{ #category : #accessing }
BlLocalImageCache >> currentSize [ 
	"Answer the approximate size of the receiver"

	^housekeeper currentSize
]

{ #category : #private }
BlLocalImageCache >> emergencySize [
	"Answer the emergency size at which the cache will be pruned by calling process"

	^housekeeper emergencySize
]

{ #category : #'accessing - cache' }
BlLocalImageCache >> ensureCacheFileForFile: aFileReference size: minImageSize [
	"Ensure that the appropriate cache file entry has been created and answer the file reference or nil if no cache entry applies"

	| fileReference cacheSize cacheFile image |

	fileReference := aFileReference asFileReference.
	cacheSize := self cacheSizeFor: minImageSize.
	(minImageSize isNil or: [ cacheSize isNil ]) ifTrue: [ ^nil ].
	cacheFile := self cacheFileFor: fileReference size: cacheSize.
	cacheFile exists ifTrue: [ ^cacheFile ].
	image := self imageFor: fileReference.
	cacheSize >= image extent max ifTrue: [ ^nil ].
	image := image scalex: cacheSize y: cacheSize keepAspectRatio: true quality: #High.
	self ensureCreateDirectory: cacheFile parent.
	image saveFile: cacheFile asAbsolute pathString format: SkiaEncodedImageFormat JPEG quality: 80.
	housekeeper add: cacheFile.
	^cacheFile.

]

{ #category : #private }
BlLocalImageCache >> ensureCreateDirectory: aFileReference [
	"Create the supplied directory ignoring DirectoryExist exceptions
	(on the assumption that the same path is being created by another worker process)"

	| count |

	count := 0.
	[ aFileReference ensureCreateDirectory ]
		on: DirectoryExists 
		do: [ :ex | count := count + 1.
			count <= 3 ifTrue: [ 
				50 milliSeconds wait.
				ex retry ] ]

]

{ #category : #'accessing - cache' }
BlLocalImageCache >> fileAt: aFileReference size: minImageSize [
	"Answer the BlImageCacheEntry for the specified file and requested size.
	If minImageSize isNil, answer the form from the original file.
	Otherwise answer the cached image which is larger than minImageSize."

	| fileReference cacheSize cacheFile image |

	fileReference := aFileReference asFileReference.
	cacheSize := self cacheSizeFor: minImageSize.
	(minImageSize isNil or: [ cacheSize isNil ]) ifTrue: [ 
		image := self imageFor: fileReference.
		^self answerImage: image size: image extent max isOriginal: true ].
	cacheFile := self cacheFileFor: fileReference size: cacheSize.
	cacheFile exists ifTrue: [ 
		hits := hits + 1.
		^self answerImage: (self imageFor: cacheFile) size: cacheSize isOriginal: false ].
	image := self imageFor: fileReference.
	cacheSize >= image extent max ifTrue: 
		[ ^self answerImage: image size: image extent max isOriginal: true ].
	image := image scalex: cacheSize y: cacheSize keepAspectRatio: true quality: #High.
	self ensureCreateDirectory: cacheFile parent.
	image saveFile: cacheFile asAbsolute pathString format: SkiaEncodedImageFormat JPEG quality: 80.
	housekeeper add: cacheFile.
	misses := misses + 1.
	^self answerImage: image size: cacheSize isOriginal: false.

]

{ #category : #private }
BlLocalImageCache >> fileRoot [
	"This is only here to facilitate testing"

	^fileRoot
]

{ #category : #manage }
BlLocalImageCache >> flush [ 
	"Remove all cached data from the receiver"

	fileRoot ensureDeleteAllChildren.
	networkRoot ensureDeleteAllChildren.
	housekeeper updateCurrentSize.
	self clearStats.
]

{ #category : #inspecting }
BlLocalImageCache >> gtStatusFor: aView [
	<gtView>
	| aList |

	aList := aView columnedList 
		title: 'Status' translated;
		priority: 50;
		items: [ { 
			'Current Size (approx.)' -> self currentSize humanReadableSIByteSize.
			'Max Cache Size' -> maxCacheSize humanReadableSIByteSize.
			'Target Size' -> self targetSize humanReadableSIByteSize.
			'Emergency Size' -> self emergencySize humanReadableSIByteSize.
			'Hits' -> self hits asString.
			'Misses' -> self misses asString.
			'Total Accesses' -> self totalAccesses asString.
			'Hit Rate' -> ((self hitRate * 100) rounded asString, '%').
			 } ].

	aList column 
		title: 'Parameter' translated;
		width: 150;
		item: [ :eachItem :eachIndex | eachItem key ].

	aList column 
		title: 'Value' translated;
		width: 70;
		item: [ :eachItem :eachIndex | eachItem value ].

	^aList
]

{ #category : #private }
BlLocalImageCache >> housekeeper [
	"This is only here to facilitate testing"

	^housekeeper
]

{ #category : #initialization }
BlLocalImageCache >> initHousekeeping [
	"Set up default housekeeping for the receiver"

	housekeeper := BlImageCacheHousekeeper for: self.
	housekeeper scheduleUpdateCurrentSize.
]

{ #category : #initialization }
BlLocalImageCache >> initialize [

	super initialize.
	self maxCacheSize: 100000000. "100MB"

]

{ #category : #private }
BlLocalImageCache >> networkRoot [
	"This is only here to facilitate testing"

	^networkRoot
]

{ #category : #initialization }
BlLocalImageCache >> setDefaultLocation [

	self cacheRoot: (FileLocator temp / 'gtoolkit' / 'cache' / 'images') resolve.

]

{ #category : #'system startup' }
BlLocalImageCache >> shutDown: quitting [
	"By default, do nothing when the session is being shut down"
]

{ #category : #private }
BlLocalImageCache >> targetSize [
	"Answer the target size when pruning the cache"

	^housekeeper targetSize
]

{ #category : #accessing }
BlLocalImageCache >> taskitRunner [

	^ taskitRunner ifNil: [ taskitRunner := BlTktWorkerProvider nonUISinglePool ]
]

{ #category : #accessing }
BlLocalImageCache >> taskitRunner: anObject [
	taskitRunner := anObject
]

{ #category : #'accessing - cache' }
BlLocalImageCache >> url: aUrl size: minImageSize for: anObject [
	"Answer the Form for the specified URL and requested size.
	If minImageSize isNil, answer the form from the original file.
	Otherwise answer the cached image which is larger than minImageSize."

	| znUrl content fileReference cacheSize cacheFile image originalSize |

	znUrl := aUrl asZnUrl.
	"If the appropriate cache entry already exists, just return it.
	Otherwise look for the original. If that doesn't exist, download it."
	minImageSize ifNotNil: [ 
		cacheSize := self cacheSizeFor: minImageSize.
		cacheFile := self cacheFileForUrl: znUrl size: cacheSize.
		cacheFile exists ifTrue: [ 
			hits := hits + 1.
			^self set: anObject image: (self imageFor: cacheFile) size: cacheSize isOriginal: false ] ].

	"The cache file doesn't exist or the original has been requested"
	"Ensure we have the original saved to file and its form loaded"
	fileReference := self cacheFileForUrl: znUrl size: nil.
	"Download the original if required"
	fileReference exists ifFalse:
		"Workaround for ZnEasy not being completely general
		(it doesn't handle #file scheme)"
		[ content := znUrl scheme = #file
				ifFalse: [ (ZnEasy get: znUrl) entity bytes ]
				ifTrue: [ znUrl asFileReference gtBinaryContents ].
		self ensureCreateDirectory: fileReference parent.
		fileReference binaryWriteStreamDo: [ :stream |
			stream nextPutAll: content ].
		housekeeper add: fileReference.
		misses := misses + 1 ].
	image := self imageFor: fileReference.
	originalSize := image extent max.

	minImageSize ifNil: [ ^self set: anObject image: image size: originalSize isOriginal: true ].

	"If the requested cache size is larger than the original, just return the original"
	cacheSize >= image extent max ifTrue: 
		[ ^self set: anObject image: image size: originalSize isOriginal: true ].

	"Answer the form scaled to cacheSize"
	image := image scalex: cacheSize y: cacheSize keepAspectRatio: true quality: SkiaFilterQuality High.
	self ensureCreateDirectory: cacheFile parent.
	image saveFile: cacheFile asAbsolute pathString format: SkiaEncodedImageFormat JPEG quality: 80.
	housekeeper add: cacheFile.
	misses := misses + 1.
	^self set: anObject image: image size: cacheSize isOriginal: false.

]
