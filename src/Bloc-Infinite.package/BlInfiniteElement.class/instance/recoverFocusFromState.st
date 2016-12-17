private - focus
recoverFocusFromState
	| aFocusTarget |

	(preserveFocusAfterLayout and: [ self hasFocus ])
		ifFalse: [ ^ self ].

	"only recover focus if InfiniteElement itself has the focus or the focused element is hidden"
	self isFocused
		ifFalse: [ 
			| aFocusedChild |
			aFocusedChild := self focusedChild.
			(aFocusedChild isNotNil and: [ childrenManager isHidden: aFocusedChild ])
				ifFalse: [ ^ self ] ].
	
	aFocusTarget := nil.
	
	(self state focusedItemPosition ~= NoPosition)
		ifTrue: [ aFocusTarget := self findElementHolderForDataSourcePosition: self state focusedItemPosition ].
	
	(aFocusTarget isNil and: [
		self state focusedItemId ~= NoId and: [
			dataSource hasStableIds ] ])
				ifTrue: [ aFocusTarget := self findElementHolderForItemId: self state focusedItemId ].
				
	(aFocusTarget isNil or: [
		aFocusTarget itemElement hasFocus or: [
			aFocusTarget itemElement hasFocusable not ] ])
				ifTrue: [ ^ self ].
	
	"could not find element to give focus to"