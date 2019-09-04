"
BlLocalImageCacheHousekeeperTest tests the main functionality of BlLocalImageCacheHousekeeper, but avoids anything that will run in a separate thread, i.e. the BlHousekeepingWorkerPool, to keep the tests simple.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cache:		<Object>
	cacheRoot:		<Object>
	fileRoot:		<Object>
	housekeeper:		<Object>
	index:		<Object>
	networkRoot:		<Object>


    Implementation Points
"
Class {
	#name : #BlLocalImageCacheHousekeepingTest,
	#superclass : #TestCase,
	#instVars : [
		'cache',
		'housekeeper',
		'cacheRoot',
		'fileRoot',
		'networkRoot',
		'index'
	],
	#category : #'Bloc-Images-Tests'
}

{ #category : #helpers }
BlLocalImageCacheHousekeepingTest >> createCachedFile [
	"Create a file in the cache and answer its FileReference"

	| fileName dirReference fileReference |

	fileName := ('file', index asString).
	dirReference := fileRoot / fileName.
	dirReference ensureCreateDirectory.
	fileReference := dirReference / fileName.
	fileReference writeStreamDo: [ :s |
		s << '0123456789' ].
	index := index + 1.
	"2 seconds wait."
	^fileReference
]

{ #category : #running }
BlLocalImageCacheHousekeepingTest >> setUp [
	
	super setUp.
	cacheRoot := FileReference newTempFilePrefix: 'Gtoolkit-Images-' suffix: '-tests'.
	cacheRoot ensureCreateDirectory.
	cache := BlLocalImageCache new.
	cache taskitRunner: TKTLocalProcessTaskRunner new.
	cache maxCacheSize: 50.
	cache cacheRoot: cacheRoot.
	fileRoot := cache fileRoot.
	networkRoot := cache networkRoot.
	housekeeper := cache housekeeper.
	index := 1.
]

{ #category : #running }
BlLocalImageCacheHousekeepingTest >> tearDown [ 

	cacheRoot ensureDeleteAll.
	super tearDown.

]

{ #category : #tests }
BlLocalImageCacheHousekeepingTest >> testEmergencySize [
	"Grow the cache beyond the emergency size and ensure that it has been reduced in size"

	"self timeLimit: 60 seconds."

	1 to: 11 do: [ :i | self createCachedFile ].
	self assert: housekeeper updateCurrentSize equals: 110.

	housekeeper pruneCache.
	self assert: housekeeper updateCurrentSize equals: 40.
]
