"
BlWorkerImageCache provides the same capabilities as ${class:name=BlLocalImageCache}$ but delegates the work of populating the cache to slave pharo processes. 


!!Public API and Key Messages

The public API is the same as for ${class:name=BlLocalImageCache}$.

"
Class {
	#name : #BlWorkerImageCache,
	#superclass : #BlLocalImageCache,
	#category : #'Bloc-Images-Cache'
}

{ #category : #'accessing - cache' }
BlWorkerImageCache >> fileAt: aFileReference size: minImageSize [
	"Anser the BlImageCacheEntry for the specified file and requested size.
	If minImageSize isNil, set the form from the original file.
	Otherwise set the cached image which is larger than minImageSize."

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

	misses := misses + 1.
	"Ask the worker to ensure that cache entry exists, then load it"
	cacheFile := (BlTlpWorkerPool current evaluate: [ BlLocalImageCache current ensureCacheFileForFile: aFileReference size: minImageSize ]).
	^cacheFile
		ifNotNil: [ self answerImage: (self imageFor: cacheFile) size: cacheSize isOriginal: false ]
		ifNil: [ 
			image := self imageFor: fileReference.
			self answerForm: image size: image extent max isOriginal: true ]
]
