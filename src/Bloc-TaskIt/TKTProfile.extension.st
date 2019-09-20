Extension { #name : #TKTProfile }

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> gtDevelopment [
	<profile: #gtDevelopment>
	^ TKTProfile
		on:
			{(#debugging -> true).
			(#runner -> BlTktWorkerProvider highUICPUBoundPool).
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
			(#runner -> BlTktWorkerProvider lowUIUserExecutionPool).
			(#poolWorkerProcess -> BlTKTWorkerProcess).
			(#process -> TKTRawProcess).
			(#errorHandler -> TKTExceptionHandler).
			(#processProvider -> BlTktProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]
