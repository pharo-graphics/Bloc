Class {
	#name : #BlImageLoadValuableTest,
	#superclass : #TestCase,
	#category : #'Bloc-Images-Tests'
}

{ #category : #accessing }
BlImageLoadValuableTest class >> resources [ 

	^{ BlImageTestResources. }
]

{ #category : #tests }
BlImageLoadValuableTest >> testValue [

	| valuable resources element entry cache |

	cache := BlLocalImageCache new setDefaultLocation.
	resources := BlImageTestResources current.
	element := BlFileImageElement new
					taskitRunner: TKTLocalProcessTaskRunner new;
					size: 200@200.
	"Force the element to look like it is open from the valuable's perspective"
	element instVarNamed: 'bounds' put: (0@0 corner: 200@200).
	"Force single threaded operation of the cache and update the current size"
	cache taskitRunner: TKTLocalProcessTaskRunner new.
	cache housekeeper updateCurrentSize.

	valuable := BlFileImageLoadValuable file: resources f1 element: element.
	valuable updateElement.
	entry := element entry.

	"Restore normal threaded operation of the cache"
	cache taskitRunner: TKTLocalProcessTaskRunner new.

	self assert: entry class equals: BlImageCacheEntry.
	"The source form is only 7@7, so the original will be returned."
	self assert: entry form width equals: 7.
	self assert: entry form height equals: 7.
	self assert: entry isOriginal.
	self assert: entry isSmallest.
]
