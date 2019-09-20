Extension { #name : #TKTProfile }

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> gtDevelopment [
	<profile: #gtDevelopment>
	^ TKTProfile
		on:
			{(#debugging -> true).
			(#runner -> [ BlTktWorkerProvider highUICPUBoundPool ]).
			(#poolWorkerProcess -> TKTDebuggWorkerProcess).
			(#process -> TKTRawProcess).
			(#errorHandler -> TKTDebuggerExceptionHandler).
			(#processProvider -> BlTktProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> gtTest [
	<profile: #gtTest>
	^ TKTProfile
		on:
			{(#debugging -> false).
			(#runner -> [ BlTktWorkerProvider lowUIUserExecutionPool ]).
			(#poolWorkerProcess -> BlTKTWorkerProcess).
			(#process -> TKTRawProcess).
			(#errorHandler -> TKTExceptionHandler).
			(#processProvider -> BlTktProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]

{ #category : #'*Bloc-TaskIt' }
TKTProfile >> values: aDictionary [
	"Set the receiver's values from the supplied dictionary"

	| values |

	values := aDictionary copy.
	"The runner uses the current profile to register itself with the service manager,
	so the receiver must be configured enough to allow the runner to be started"
	self 
		debugging: (values removeKey: #debugging);
		errorHandler: (values removeKey: #errorHandler);
		processProvider: (values removeKey: #processProvider);
		process: (values removeKey: #process);
		poolWorkerProcess: (values removeKey: #poolWorkerProcess);
		serviceManager: (values removeKey: #serviceManager).
	TKTConfiguration value: self during: 
		[ self runner: (values removeKey: #runner) value ].
	
	values keysAndValuesDo: [ :k :v | self perform: ('{1}:' format: {k}) asSymbol withArguments: {v} ]
]
