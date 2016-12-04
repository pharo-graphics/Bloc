private - testing
hasUpdatedChild
	"Return true if any of existing elemnts holder needs to be updated"
	<return: #Boolean>

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and:[
			anElementHolder isUpdated ])
				ifTrue: [ ^ true ] ].
	^ false 