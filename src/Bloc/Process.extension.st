Extension { #name : #Process }

{ #category : #'*Bloc' }
Process >> isBlocPulseLoopProcess [
	"Verify if this process is representing a pulsing loop. A pusling loop is 
	reponsible with running pluses in a universe. This does not mean that this 
	process is the current active UI process in any Bloc universe, only that
	it implements the functionaliy of running a UI Loop. This process can be 
	the current UI process in a universe, a previous UI process that was interrupted
	or a process that was the UI process and was replaced with another UI process."
	
	^ self name = BlHostPulseLoop processId
]
