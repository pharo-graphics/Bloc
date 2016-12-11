running
run
	self halt.
	(infiniteElement isFirstLayoutComplete not or: [
		infiniteElement isLayoutRequested ])
			"a layout request will happen, we should not do layout here."
			ifTrue: [ ^ self ].
	
	infiniteElement isAttached
		ifFalse: [ 
			"if we are not attached yet, mark us as requiring layout and skip"
			infiniteElement requestLayout.
			^ self ].

	infiniteElement isLayoutFrozen
		ifTrue: [
			infiniteElement markLayoutRequestEaten.
			"we'll process updates when ice age ends."
			^ self ].
	
	"actually perform all necessary updates and trigger layout update"
	infiniteElement consumePendingDataSourceCommands