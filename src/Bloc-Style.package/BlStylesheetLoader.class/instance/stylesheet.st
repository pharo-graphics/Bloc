grammar
stylesheet
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := BlStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]