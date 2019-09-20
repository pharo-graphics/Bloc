Extension { #name : #TKTProfile }

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> gtTest [
	<profile: #test>
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
