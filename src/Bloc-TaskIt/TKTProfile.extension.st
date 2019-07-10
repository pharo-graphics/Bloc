Extension { #name : #TKTProfile }

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> blocAsyncUI [
	<profile: #blocAsyncUI>
	^ TKTProfile
		on:
			{(#debugging -> true).
			(#runner -> BlAsyncUIWorkerPool createDefault).
			(#poolWorkerProcess -> TKTDebuggWorkerProcess).
			(#process -> TKTRawProcess).
			(#errorHandler -> TKTDebuggerExceptionHandler).
			(#processProvider -> TKTTaskItProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> blocHousekeeping [
	<profile: #blocHousekeeping>
	^ TKTProfile
		on:
			{(#debugging -> true).
			(#runner -> BlHousekeepingWorkerPool createDefault).
			(#poolWorkerProcess -> TKTDebuggWorkerProcess).
			(#process -> TKTRawProcess).
			(#errorHandler -> TKTDebuggerExceptionHandler).
			(#processProvider -> TKTTaskItProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]
