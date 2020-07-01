Class {
	#name : #BlLocalImageCacheTest,
	#superclass : #TestCase,
	#category : #'Bloc-Images-Tests'
}

{ #category : #accessing }
BlLocalImageCacheTest class >> resources [ 

	^{ BlLocalImageCacheTestResources. }
]

{ #category : #accessing }
BlLocalImageCacheTest >> cache [ 

	^self resource cache
]

{ #category : #accessing }
BlLocalImageCacheTest >> resource [

	^self class resources first current
]

{ #category : #tests }
BlLocalImageCacheTest >> testCacheFileForSize [

	| cache file cacheFile |

	cache := BlLocalImageCacheTestResources current cache.
	file := '/a/b/c.jpg' asFileReference.
	cacheFile := cache cacheFileFor: file size: 200.
	self assert: cacheFile 
			equals: cache fileRoot / 'a' / 'b' / 'c.jpg' / '200.jpg'
]

{ #category : #tests }
BlLocalImageCacheTest >> testCacheFileForUrlSize [

	| url znUrl cache hash cacheFile |

	url := 'https://gtoolkit.com/pictures/gtoolkit-icon.png'.
	znUrl := url asZnUrl.
	hash := (SHA256 new hashStream: znUrl asString readStream) hex.
	cache := BlLocalImageCacheTestResources current cache.
	cacheFile := cache cacheFileForUrl: znUrl size: nil.
	self assert: cacheFile 
			equals: cache networkRoot / hash / 'original.image'.
	cacheFile := cache cacheFileForUrl: url asZnUrl size: 200.
	self assert: cacheFile 
			equals: cache networkRoot / hash / '200.jpg'
]

{ #category : #tests }
BlLocalImageCacheTest >> testCacheSizeFor [

	| cache requestedSize |

	cache := BlLocalImageCache new.
	cache taskitRunner: TKTLocalProcessTaskRunner new.
	self assert: (cache cacheSizeFor: 10) equals: cache defaultImageSizes first.
	requestedSize := cache defaultImageSizes second - 1.
	self assert: (cache cacheSizeFor: requestedSize) equals: cache defaultImageSizes second.
	requestedSize := cache defaultImageSizes second.
	self assert: (cache cacheSizeFor: requestedSize) equals: cache defaultImageSizes second.
	requestedSize := cache defaultImageSizes third + 1.
	self assert: (cache cacheSizeFor: requestedSize) equals: cache defaultImageSizes last.
	requestedSize := cache defaultImageSizes last + 1.
	self assert: (cache cacheSizeFor: requestedSize) isNil.

]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSize100 [

	| cache entry cachedForm maxDimension element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image1200 size: 100 for: element.
	entry := element entry.
	cachedForm := entry image.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 200.
	self assert: entry isSmallest.
	self deny: entry isOriginal.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSize200 [

	| cache cachedForm maxDimension element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image1200 size: 200 for: element.
	cachedForm := element entry image.
	maxDimension := cachedForm extent max.
	"The next largest size is 200"
	self 
		assert: maxDimension 
		equals: 200
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSize2000 [

	| cache entry cachedForm maxDimension element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image1200 size: 2000 for: element.
	entry := element entry.
	cachedForm := entry image.
	maxDimension := cachedForm extent max.
	"This is larger than the original, we should get back the original"
	self 
		assert: maxDimension 
		equals: 1200.
	self assert: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSize400 [

	| cache entry cachedForm maxDimension element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image400 size: 400 for: element.
	entry := element entry.
	cachedForm := entry image.
	maxDimension := cachedForm extent max.
	self 
		assert: maxDimension 
		equals: 400.
	self assert: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSize700 [

	| cache entry cachedForm maxDimension element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image1200 size: 700 for: element.
	entry := element entry.
	cachedForm := entry image.
	maxDimension := cachedForm width max: cachedForm height.
	"The next largest size is 800"
	self 
		assert: maxDimension 
		equals: 800.
	self deny: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedSizeNil [

	| cache entry element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache fileAt: self resource image1200 size: nil for: element.
	entry := element entry.
	self 
		assert: entry image extent
		equals: (ImageReadWriter gtFormFromFileReference: self resource image1200) extent.
	self assert: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedUrlSize100 [

	| cache element entry |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache url: self resource image400 asZnUrl size: 100 for: element.
	entry := element entry.
	"The next largest size is 200"
	self 
		assert: entry image extent max
		equals: 200.
	self assert: entry isSmallest.
	self deny: entry isOriginal.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedUrlSize400 [

	| cache element entry |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache url: self resource image400 asZnUrl size: 400 for: element.
	entry := element entry.
	self 
		assert: entry image extent max
		equals: 400.
	self assert: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testCachedUrlSize800 [

	| cache element entry |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache url: self resource image400 asZnUrl size: 800 for: element.
	entry := element entry.
	"800 is larger than the original, so we should get back the original"
	self 
		assert: entry image extent max
		equals: 400.
	self assert: entry isOriginal.
	self deny: entry isSmallest.
]

{ #category : #tests }
BlLocalImageCacheTest >> testFlush [

	| cache element |

	cache := self cache.
	element := BlImageCacheTestEntry new.
	cache flush.
	cache fileAt: self resource image1200 size: 100 for: element.
	cache fileAt: self resource image1200 size: 300 for: element.
	cache fileAt: self resource image1200 size: 700 for: element.

	self 
		assert: (self resource cacheRoot allChildren select: [ :each | each basename endsWith: 'jpg' ]) size
		equals: 4.

	cache flush.

	self 
		assert: (self resource cacheRoot allChildren select: [ :each | each basename endsWith: 'jpg' ]) size
		equals: 0

]
