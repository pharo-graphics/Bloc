Class {
	#name : #BlInfiniteDataSourceCommandTypeFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Add',
		'Move',
		'Remove',
		'Update'
	],
	#category : #'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteDataSourceCommandTypeFlags class >> Add [
	"This method was automatically generated"
	^ Add value
]

{ #category : #'accessing - flags' }
BlInfiniteDataSourceCommandTypeFlags class >> Move [
	"This method was automatically generated"
	^ Move value
]

{ #category : #'accessing - flags' }
BlInfiniteDataSourceCommandTypeFlags class >> Remove [
	"This method was automatically generated"
	^ Remove value
]

{ #category : #'accessing - flags' }
BlInfiniteDataSourceCommandTypeFlags class >> Update [
	"This method was automatically generated"
	^ Update value
]

{ #category : #'flags declaration' }
BlInfiniteDataSourceCommandTypeFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#ADD.
		#REMOVE.
		#UPDATE.	
		#MOVE.
	}
]

{ #category : #initialization }
BlInfiniteDataSourceCommandTypeFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
BlInfiniteDataSourceCommandTypeFlags >> addAdd [
	"This method was automatically generated"
	value := value | Add value
]

{ #category : #'flags - add' }
BlInfiniteDataSourceCommandTypeFlags >> addMove [
	"This method was automatically generated"
	value := value | Move value
]

{ #category : #'flags - add' }
BlInfiniteDataSourceCommandTypeFlags >> addRemove [
	"This method was automatically generated"
	value := value | Remove value
]

{ #category : #'flags - add' }
BlInfiniteDataSourceCommandTypeFlags >> addUpdate [
	"This method was automatically generated"
	value := value | Update value
]

{ #category : #'flags - clear' }
BlInfiniteDataSourceCommandTypeFlags >> clearAdd [
	"This method was automatically generated"
	value := value & (Add value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteDataSourceCommandTypeFlags >> clearMove [
	"This method was automatically generated"
	value := value & (Move value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteDataSourceCommandTypeFlags >> clearRemove [
	"This method was automatically generated"
	value := value & (Remove value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteDataSourceCommandTypeFlags >> clearUpdate [
	"This method was automatically generated"
	value := value & (Update value bitInvert)
]

{ #category : #'flags - testing' }
BlInfiniteDataSourceCommandTypeFlags >> hasAdd [
	"This method was automatically generated"
	^ (value & Add value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteDataSourceCommandTypeFlags >> hasMove [
	"This method was automatically generated"
	^ (value & Move value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteDataSourceCommandTypeFlags >> hasRemove [
	"This method was automatically generated"
	^ (value & Remove value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteDataSourceCommandTypeFlags >> hasUpdate [
	"This method was automatically generated"
	^ (value & Update value) ~= 0
]
