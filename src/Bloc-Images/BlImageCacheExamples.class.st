Class {
	#name : #BlImageCacheExamples,
	#superclass : #Object,
	#instVars : [
		'image1200',
		'image400'
	],
	#category : #'Bloc-Images-Examples'
}

{ #category : #tests }
BlImageCacheExamples >> deleteTestImages [

	image400 ifNotNil: [ image400 ensureDelete ].
	image1200 ifNotNil: [ image1200 ensureDelete ].
]

{ #category : #tests }
BlImageCacheExamples >> getCachedSize100 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self image1200 size: 100 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 200.
	self assert: entry isSmallest.
	self assert: entry isOriginal not.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedSize200 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self image1200 size: 200 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 200.
	self assert: entry isSmallest.
	self assert: entry isOriginal not.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedSize2000 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self image1200 size: 2000 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 1200.
	self assert: entry isSmallest not.
	self assert: entry isOriginal.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedSize400 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self image400 size: 400 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 400.
	self assert: entry isSmallest not.
	self assert: entry isOriginal.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedSize700 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self image1200 size: 700 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 800.
	self assert: entry isSmallest not.
	self assert: entry isOriginal not.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedUrlSize300 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache url: self image1200 asZnUrl size: 300 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	self 
		assert: maxDimension 
		equals: 400.
	self assert: entry isSmallest not.
	self assert: entry isOriginal not.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedUrlSize400 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache url: self image400 asZnUrl size: 400 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	self 
		assert: maxDimension 
		equals: 400.
	self assert: entry isSmallest not.
	self assert: entry isOriginal.
]

{ #category : #tests }
BlImageCacheExamples >> getCachedUrlSize800 [
	<gtExample>
	<after: #deleteTestImages>

	| cache entry cachedForm maxDimension element |

	cache := self newCache.
	element := BlImageCacheTestEntry new.
	cache url: self image400 asZnUrl size: 800 for: element.
	entry := element entry.
	cachedForm := entry form.
	maxDimension := cachedForm extent max.
	self 
		assert: maxDimension 
		equals: 400.
	self assert: entry isSmallest not.
	self assert: entry isOriginal.
]

{ #category : #accessing }
BlImageCacheExamples >> image1200 [

	^image1200 ifNil: [ 
		image1200 := FileReference newTempFilePrefix: 'BlImageCacheExamples-' suffix: '.jpg'.
		PluginBasedJPEGReadWriter 
			putForm: (self testForm scaledToSize: 1200@900) 
			onFileNamed: image1200.
		image1200 ]
]

{ #category : #accessing }
BlImageCacheExamples >> image400 [

	^image400 ifNil: [ 
		image400 := FileReference newTempFilePrefix: 'BlImageCacheExamples-' suffix: '.jpg'.
		PluginBasedJPEGReadWriter 
			putForm: self testForm
			onFileNamed: image400.
		image400 ]
]

{ #category : #examples }
BlImageCacheExamples >> newCache [ 
	"Answer a new memory cache"
	<gtExample>

	| cache |

	cache := BlMemoryImageCache new.
	"Check that the default size has been set"
	self assert: cache cacheSize equals: 5.
	cache imageSizes: #(200 400 800).
	^cache
]

{ #category : #examples }
BlImageCacheExamples >> smallCache [
	"Answer a small cache that we can quickly fill"
	<gtExample>

	| cache |

	cache := self newCache.
	cache maxCacheSize: 2.
	self assert: cache cacheSize equals: 2.
	^cache
]

{ #category : #tests }
BlImageCacheExamples >> testCacheSizeFor [
	<gtExample>

	| cache |

	cache := self smallCache.
	self assert: (cache cacheSizeFor: 100) equals: 200.
	self assert: (cache cacheSizeFor: 200) equals: 200.
	self assert: (cache cacheSizeFor: 400-1) equals: 400.
	self assert: (cache cacheSizeFor: 400) equals: 400.
	self assert: (cache cacheSizeFor: 400+1) equals: 800.
	self assert: (cache cacheSizeFor: 800+1) isNil.

]

{ #category : #tests }
BlImageCacheExamples >> testDeafultImageSizes [
	<gtExample>

	| defaultSizes |

	defaultSizes := BlMemoryImageCache new defaultImageSizes.
	self assert: defaultSizes size equals: 3.
	self assert: defaultSizes first equals: 200.
	^defaultSizes
]

{ #category : #tests }
BlImageCacheExamples >> testForm [
	"Create a form that can be used to test the cache"
	<gtExample>

	| form canvas |

	form := Form extent: 400@300.
	canvas := FormCanvas on: form.
	canvas
		drawString: Date today printString, ' ', Time now print24
		at: 10@150
		font: (LogicalFont familyName: 'Bitmap DejaVu Sans' pointSize: 100)
		color: Color black.
	^form
]
