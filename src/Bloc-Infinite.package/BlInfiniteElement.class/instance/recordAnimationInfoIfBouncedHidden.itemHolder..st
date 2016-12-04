private - animations
recordAnimationInfoIfBouncedHidden: anElementHolder itemHolder: anItemHolder
	"Record the animation information for an element holder that was bounced from hidden list.
	It also clears the bounce back flag."

	"looks like this view bounced back from hidden list!"
	anElementHolder flags clearBouncedFromHiddenList.
	
	(self state trackOldChangeHolders and: [
		anElementHolder isUpdated and: [ 
			anElementHolder isRemoved not and: [
				anElementHolder shouldIgnore not ] ] ])
		ifTrue: [ 
			| aKey |
			aKey := self changedHolderKeyOf: anElementHolder.
			infoStore addToOldChangeHolders: anElementHolder at: aKey ].
	
	infoStore addToPreLayout: anElementHolder itemHolder: anItemHolder