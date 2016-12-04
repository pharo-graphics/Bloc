layout
dispatchLayoutThirdStepSimpleAnimations
	"Find out where things are now, and process change animations.
	Traverse list in reverse because we may call animateChange in the loop which may
	remove the target element holder"	
	
	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aKey anAnimationInfo oldChangeHolder |
			aKey := self changedHolderKeyOf: anElementHolder.
			anAnimationInfo := itemAnimator recordPostLayoutInformation: self state holder: anElementHolder.
			oldChangeHolder := infoStore oldChangedHolderAt: aKey.
			(oldChangeHolder isNotNil and: [ oldChangeHolder shouldIgnore not ])
				ifTrue: [ 
					| oldDisappearing newDisappearing |
					"run a change animation"
					oldDisappearing := infoStore isDisappearing: oldChangeHolder.
					newDisappearing := infoStore isDisappearing: anElementHolder.
					(oldDisappearing and: [ oldChangeHolder == anElementHolder ])
						"run disappear animation instead of change"
						ifTrue: [ infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo ]
						ifFalse: [ 
							| aPreInfo aPostInfo |
							aPreInfo := infoStore popFromPreLayout: oldChangeHolder.
							"we add and remove so that any post info is merged"
							infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo.
							aPostInfo := infoStore popFromPostLayout: anElementHolder.
							aPreInfo
								ifNil: [ self handleMissingPreInfoForChange: anElementHolder oldChangeHolder: oldChangeHolder at: aKey ]
								ifNotNil: [ self flag: 'animateChange(oldChangeViewHolder, holder, preInfo, postInfo, oldDisappearing, newDisappearing)' ] ] ]
				ifFalse: [ 
					infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo ] ] ].
	
	"Process element info lists and trigger animations"
	infoStore processOn: infoStoreProcessor