Class {
	#name : #BlLocalImageCacheTestResources,
	#superclass : #TestResource,
	#instVars : [
		'resourceRoot',
		'cacheRoot',
		'fileRoot',
		'cache'
	],
	#category : #'Bloc-Images-Tests'
}

{ #category : #accessing }
BlLocalImageCacheTestResources >> cache [
	^ cache
]

{ #category : #accessing }
BlLocalImageCacheTestResources >> cacheRoot [
	^ cacheRoot
]

{ #category : #accessing }
BlLocalImageCacheTestResources >> fileRoot [
	^ fileRoot
]

{ #category : #accessing }
BlLocalImageCacheTestResources >> image1200 [

	^fileRoot / 'image1200.jpg'
]

{ #category : #accessing }
BlLocalImageCacheTestResources >> image400 [

	^fileRoot / 'image400.jpg'
]

{ #category : #running }
BlLocalImageCacheTestResources >> setUp [ 

	| form |

	super setUp.
	resourceRoot := FileReference newTempFilePrefix: 'Gtoolkit-Images-' suffix: '-tests'.
	resourceRoot ensureCreateDirectory.
	cacheRoot := resourceRoot / 'cache'.
	cacheRoot ensureCreateDirectory.
	fileRoot := resourceRoot / 'files'.
	fileRoot ensureCreateDirectory.
	cache := BlLocalImageCache new.
	cache taskitRunner: TKTLocalProcessTaskRunner new.
	cache imageSizes: #(200 400 800).
	cache cacheRoot: cacheRoot.

	form := self testForm.
	PluginBasedJPEGReadWriter putForm: form onFileNamed: self image400.
	form := form scaledToSize: 1200@900.
	PluginBasedJPEGReadWriter putForm: form onFileNamed: self image1200.
]

{ #category : #running }
BlLocalImageCacheTestResources >> tearDown [ 

	resourceRoot ensureDeleteAll.
	super tearDown
]

{ #category : #accessing }
BlLocalImageCacheTestResources >> testForm [
	"Create a form that can be used to test the cache"

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
