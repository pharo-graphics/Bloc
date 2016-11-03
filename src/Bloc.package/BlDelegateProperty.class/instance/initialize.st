accessing
initialize
	super initialize.
	delegationBlock := [ :p :v | 
		(p perform: self name) = v ifFalse: [
			p perform: self name asMutator with: v ] ]