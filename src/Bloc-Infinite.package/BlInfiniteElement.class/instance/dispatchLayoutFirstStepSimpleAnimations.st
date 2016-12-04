layout
dispatchLayoutFirstStepSimpleAnimations
	"Find out where all non-removed items are, pre-layout"
	
	self
		assert: [ self state willRunSimpleAnimations ]
		description: [ 'My state must be running simple animations!' ].

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore or: [
			anElementHolder isInvalid and: [
				dataSource hasStableIds not ] ])
			ifFalse: [ 
				| animationInfo |
				animationInfo := itemAnimator
					recordPreLayoutInformation: self state
					holder: anElementHolder
					flags: (itemAnimator buildDataSourceChangeFlagsForAnimations: anElementHolder)
					payloads: anElementHolder payloads.
				
				infoStore addToPreLayout: anElementHolder itemHolder: animationInfo.
				
				(self state trackOldChangeHolders and: [
					anElementHolder isUpdated and: [
						anElementHolder isRemoved not and: [ 
							anElementHolder shouldIgnore not and: [ 
								anElementHolder isInvalid not ] ] ] ])
					ifTrue: [ 
						| aKey |
						aKey := self changedHolderKeyOf: anElementHolder.
						infoStore addToOldChangeHolders: anElementHolder at: aKey ] ] ]