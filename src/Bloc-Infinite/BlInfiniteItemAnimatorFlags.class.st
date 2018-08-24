Class {
	#name : #BlInfiniteItemAnimatorFlags,
	#superclass : #BlInfiniteFlags,
	#classVars : [
		'AppearedInPreLayout',
		'Changed',
		'Invalidated',
		'Moved',
		'Removed'
	],
	#category : 'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteItemAnimatorFlags class >> AppearedInPreLayout [
	"This method was automatically generated"
	^ AppearedInPreLayout value
]

{ #category : #'accessing - flags' }
BlInfiniteItemAnimatorFlags class >> Changed [
	"This method was automatically generated"
	^ Changed value
]

{ #category : #'accessing - flags' }
BlInfiniteItemAnimatorFlags class >> Invalidated [
	"This method was automatically generated"
	^ Invalidated value
]

{ #category : #'accessing - flags' }
BlInfiniteItemAnimatorFlags class >> Moved [
	"This method was automatically generated"
	^ Moved value
]

{ #category : #'accessing - flags' }
BlInfiniteItemAnimatorFlags class >> Removed [
	"This method was automatically generated"
	^ Removed value
]

{ #category : #'flags declaration' }
BlInfiniteItemAnimatorFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#CHANGED -> [ BlInfiniteElementHolderFlags Update ].
		#REMOVED -> [ BlInfiniteElementHolderFlags Removed ].
		#INVALIDATED -> [ BlInfiniteElementHolderFlags Invalid ].
		#MOVED -> [ BlInfiniteElementHolderFlags Moved ].
		#APPEARED_IN_PRE_LAYOUT -> [ BlInfiniteElementHolderFlags AppearedInPreLayout ]
	}
]

{ #category : #initialization }
BlInfiniteItemAnimatorFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
BlInfiniteItemAnimatorFlags >> addAppearedInPreLayout [
	"This method was automatically generated"
	value := value | AppearedInPreLayout value
]

{ #category : #'flags - add' }
BlInfiniteItemAnimatorFlags >> addChanged [
	"This method was automatically generated"
	value := value | Changed value
]

{ #category : #'flags - add' }
BlInfiniteItemAnimatorFlags >> addInvalidated [
	"This method was automatically generated"
	value := value | Invalidated value
]

{ #category : #'flags - add' }
BlInfiniteItemAnimatorFlags >> addMoved [
	"This method was automatically generated"
	value := value | Moved value
]

{ #category : #'flags - add' }
BlInfiniteItemAnimatorFlags >> addRemoved [
	"This method was automatically generated"
	value := value | Removed value
]

{ #category : #'flags - clear' }
BlInfiniteItemAnimatorFlags >> clearAppearedInPreLayout [
	"This method was automatically generated"
	value := value & (AppearedInPreLayout value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteItemAnimatorFlags >> clearChanged [
	"This method was automatically generated"
	value := value & (Changed value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteItemAnimatorFlags >> clearInvalidated [
	"This method was automatically generated"
	value := value & (Invalidated value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteItemAnimatorFlags >> clearMoved [
	"This method was automatically generated"
	value := value & (Moved value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteItemAnimatorFlags >> clearRemoved [
	"This method was automatically generated"
	value := value & (Removed value bitInvert)
]

{ #category : #'flags - testing' }
BlInfiniteItemAnimatorFlags >> hasAppearedInPreLayout [
	"This method was automatically generated"
	^ (value & AppearedInPreLayout value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteItemAnimatorFlags >> hasChanged [
	"This method was automatically generated"
	^ (value & Changed value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteItemAnimatorFlags >> hasInvalidated [
	"This method was automatically generated"
	^ (value & Invalidated value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteItemAnimatorFlags >> hasMoved [
	"This method was automatically generated"
	^ (value & Moved value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteItemAnimatorFlags >> hasRemoved [
	"This method was automatically generated"
	^ (value & Removed value) ~= 0
]
