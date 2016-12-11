animations
endAnimation: anElementHolder
	"Ends all animations on the elements created by the ItemAnimator"
	
	infiniteElement itemAnimator supportsAnimations
		ifTrue: [ infiniteElement itemAnimator endAnimation: anElementHolder ]