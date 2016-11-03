grammar value
function
	^ super function
		==> [ :nodes | 
			{nodes first.
			(nodes third reject: [ :item | item = $, ])} ]