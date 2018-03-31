private - accessing
isInChangeScrap
	"Return true if I am inside of change scrap of attached
	recycler, false otherwise.
	If I am not attached to recycler return false"
	<return: #Boolean>
	
	self
		assert: [ isInChangeScrap ifTrue: [ recycler isNotNil ] ifFalse: [ true ] ]
		description: [ 'Recycler must be attached if I am in change scrap' ].
	
	^ isInChangeScrap