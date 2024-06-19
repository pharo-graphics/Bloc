Class {
	#name : #BlInfiniteElementHolderFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Bound',
		'DataSourcePositionUnknown',
		'Ignore',
		'Invalid',
		'Removed',
		'ReturnedFromScrap',
		'TmpDetached',
		'Update'
	],
	#category : #'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> Bound [
	"This method was automatically generated"
	^ Bound value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> DataSourcePositionUnknown [
	"This method was automatically generated"
	^ DataSourcePositionUnknown value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> Ignore [
	"This method was automatically generated"
	^ Ignore value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> Invalid [
	"This method was automatically generated"
	^ Invalid value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> Removed [
	"This method was automatically generated"
	^ Removed value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> ReturnedFromScrap [
	"This method was automatically generated"
	^ ReturnedFromScrap value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> TmpDetached [
	"This method was automatically generated"
	^ TmpDetached value
]

{ #category : #'accessing - flags' }
BlInfiniteElementHolderFlags class >> Update [
	"This method was automatically generated"
	^ Update value
]

{ #category : #'flags declaration' }
BlInfiniteElementHolderFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"

	^ { #REMOVED. #INVALID. #RETURNED_FROM_SCRAP. #BOUND. #DATA_SOURCE_POSITION_UNKNOWN.
	  #IGNORE. #UPDATE. #TMP_DETACHED }
]

{ #category : #initialization }
BlInfiniteElementHolderFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addBound [
	"This method was automatically generated"
	value := value | Bound value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addDataSourcePositionUnknown [
	"This method was automatically generated"
	value := value | DataSourcePositionUnknown value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addIgnore [
	"This method was automatically generated"
	value := value | Ignore value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addInvalid [
	"This method was automatically generated"
	value := value | Invalid value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addRemoved [
	"This method was automatically generated"
	value := value | Removed value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addReturnedFromScrap [
	"This method was automatically generated"
	value := value | ReturnedFromScrap value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addTmpDetached [
	"This method was automatically generated"
	value := value | TmpDetached value
]

{ #category : #'flags - add' }
BlInfiniteElementHolderFlags >> addUpdate [
	"This method was automatically generated"
	value := value | Update value
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearBound [
	"This method was automatically generated"
	value := value & (Bound value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearDataSourcePositionUnknown [
	"This method was automatically generated"
	value := value & (DataSourcePositionUnknown value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearIgnore [
	"This method was automatically generated"
	value := value & (Ignore value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearInvalid [
	"This method was automatically generated"
	value := value & (Invalid value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearRemoved [
	"This method was automatically generated"
	value := value & (Removed value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearReturnedFromScrap [
	"This method was automatically generated"
	value := value & (ReturnedFromScrap value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearTmpDetached [
	"This method was automatically generated"
	value := value & (TmpDetached value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteElementHolderFlags >> clearUpdate [
	"This method was automatically generated"
	value := value & (Update value bitInvert)
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasBound [
	"This method was automatically generated"
	^ (value & Bound value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasDataSourcePositionUnknown [
	"This method was automatically generated"
	^ (value & DataSourcePositionUnknown value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasIgnore [
	"This method was automatically generated"
	^ (value & Ignore value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasInvalid [
	"This method was automatically generated"
	^ (value & Invalid value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasRemoved [
	"This method was automatically generated"
	^ (value & Removed value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasReturnedFromScrap [
	"This method was automatically generated"
	^ (value & ReturnedFromScrap value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasTmpDetached [
	"This method was automatically generated"
	^ (value & TmpDetached value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteElementHolderFlags >> hasUpdate [
	"This method was automatically generated"
	^ (value & Update value) ~= 0
]
