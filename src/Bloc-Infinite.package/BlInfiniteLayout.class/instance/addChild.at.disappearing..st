private - children
addChild: anElement at: anIndex disappearing: isDisappearing
	"If anIndex == 0 child will be attached at the end"

	| anElementHolder anInfiniteConstraints |
	
	anElementHolder := self elementHolderOf: anElement.
	
	(isDisappearing or: [ anElementHolder isRemoved ])
		ifTrue: [ self addToDisappearedInLayout: anElementHolder ]
		ifFalse: [ self removeFromDisappearedInLayout: anElementHolder ].
		
	anInfiniteConstraints := anElement constraints infinite.
	
	(anElementHolder wasReturnedFromScrap or: [ anElementHolder isScrap ])
		ifTrue: [
			anElementHolder isScrap
				ifTrue: [ anElementHolder unscrap ]
				ifFalse: [ anElementHolder clearReturnedFromScrap ].
			childManager attachChild: anElement at: anIndex hidden: false ]
		ifFalse: [ 
			anElement parent == infiniteElement
				ifTrue: [ 
					| currentIndex index |
					index := anIndex = 0
						ifTrue: [ childManager childrenCount ]
						ifFalse: [ anIndex ].
					currentIndex := childManager childIndexOf: anElement.
					currentIndex <= 0
						ifTrue: [ self error: 'Added element has infinite element as parent but is not a direct child of it' ].
					currentIndex ~= index
						ifTrue: [ self moveChildFrom: currentIndex to: index ] ]
				ifFalse: [ 
					childManager addChild: anElement at: anIndex hidden: false.
					anInfiniteConstraints insetsDirty: true.
					self flag: 'smooth scroller'
					"smoothScroller onChildAttached: anElement" ] ].
			
	anInfiniteConstraints pendingInvalidate ifTrue: [ 
		anElementHolder itemElement changed.
		anElementHolder pendingInvalidate: false ]