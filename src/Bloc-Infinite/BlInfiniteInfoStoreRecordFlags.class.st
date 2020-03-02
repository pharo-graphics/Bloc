Class {
	#name : #BlInfiniteInfoStoreRecordFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Appear',
		'Disappeared',
		'Post',
		'Pre'
	],
	#category : #'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteInfoStoreRecordFlags class >> Appear [
	"This method was automatically generated"
	^ Appear value
]

{ #category : #'accessing - flags' }
BlInfiniteInfoStoreRecordFlags class >> Disappeared [
	"This method was automatically generated"
	^ Disappeared value
]

{ #category : #'accessing - flags' }
BlInfiniteInfoStoreRecordFlags class >> Post [
	"This method was automatically generated"
	^ Post value
]

{ #category : #'accessing - flags' }
BlInfiniteInfoStoreRecordFlags class >> Pre [
	"This method was automatically generated"
	^ Pre value
]

{ #category : #'flags declaration' }
BlInfiniteInfoStoreRecordFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#DISAPPEARED. 	"disappearing list"
		#APPEAR.	"appear in pre layout list"
		#PRE.		"pre layout, this is necessary to distinguish null item info"
		#POST.		"post layout, this is necessary to distinguish null item info"
	}
]

{ #category : #initialization }
BlInfiniteInfoStoreRecordFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
BlInfiniteInfoStoreRecordFlags >> addAppear [
	"This method was automatically generated"
	value := value | Appear value
]

{ #category : #'flags - add' }
BlInfiniteInfoStoreRecordFlags >> addDisappeared [
	"This method was automatically generated"
	value := value | Disappeared value
]

{ #category : #'flags - add' }
BlInfiniteInfoStoreRecordFlags >> addPost [
	"This method was automatically generated"
	value := value | Post value
]

{ #category : #'flags - add' }
BlInfiniteInfoStoreRecordFlags >> addPre [
	"This method was automatically generated"
	value := value | Pre value
]

{ #category : #'flags - clear' }
BlInfiniteInfoStoreRecordFlags >> clearAppear [
	"This method was automatically generated"
	value := value & (Appear value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteInfoStoreRecordFlags >> clearDisappeared [
	"This method was automatically generated"
	value := value & (Disappeared value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteInfoStoreRecordFlags >> clearPost [
	"This method was automatically generated"
	value := value & (Post value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteInfoStoreRecordFlags >> clearPre [
	"This method was automatically generated"
	value := value & (Pre value bitInvert)
]

{ #category : #'flags - testing' }
BlInfiniteInfoStoreRecordFlags >> hasAppear [
	"This method was automatically generated"
	^ (value & Appear value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteInfoStoreRecordFlags >> hasDisappeared [
	"This method was automatically generated"
	^ (value & Disappeared value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteInfoStoreRecordFlags >> hasPost [
	"This method was automatically generated"
	^ (value & Post value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteInfoStoreRecordFlags >> hasPre [
	"This method was automatically generated"
	^ (value & Pre value) ~= 0
]
