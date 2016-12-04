layout
dispatchLayoutFirstStepPredictiveAnimations
	"Perform prelayout. I will use the old positions of items.
	The infinite layout is expected to layout everything,
	even removed items (though not to add removed items back to the container).
	This gives the pre-layout position of APPEARING views which come into existence as part of the real layout"
	| didStructureChange |
	
	"Save old positions so that InfiniteLayout can run its mapping logic."
	self saveOldPositions.
	
	"temporarily disable flag because we are asking for previous layout"
	didStructureChange := self state didStructureChange.
	self state structureChanged: false.
	layout layoutChildren.
	self state structureChanged: didStructureChange.
	
	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore or: [
			infoStore isInPreLayout: anElementHolder ])
				ifFalse: [ 
					| theFlags wasHidden anAnimationInfo |
					theFlags := itemAnimator buildDataSourceChangeFlagsForAnimations: anElementHolder.
					wasHidden := anElementHolder flags hasBouncedFromHiddenList.
					wasHidden
						ifFalse: [ theFlags addAppearedInPreLayout ].
					anAnimationInfo := itemAnimator
						recordPreLayoutInformation: self state
						holder: anElementHolder
						flags: theFlags
						payloads: anElementHolder payloads.
					wasHidden
						ifTrue: [ self recordAnimationInfoIfBouncedHidden: anElementHolder itemHolder: anAnimationInfo ]
						ifFalse: [ infoStore addToAppearedInPreLayout: anElementHolder itemHolder: anAnimationInfo ] ] ]