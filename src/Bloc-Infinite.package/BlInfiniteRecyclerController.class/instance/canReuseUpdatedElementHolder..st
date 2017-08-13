recycler -> animator
canReuseUpdatedElementHolder: anElementHolder
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ infiniteElement itemAnimator supportsAnimations not or: [ 
			infiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]