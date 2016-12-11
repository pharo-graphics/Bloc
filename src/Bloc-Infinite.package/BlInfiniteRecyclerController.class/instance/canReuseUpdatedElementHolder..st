recycler -> animator
canReuseUpdatedElementHolder: anElementHolder
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ infiniteElement itemAnimator supportsAnimations and: [ 
			infiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]