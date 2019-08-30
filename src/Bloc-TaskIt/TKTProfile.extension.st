Extension { #name : #TKTProfile }

{ #category : #'*Bloc-TaskIt' }
TKTProfile class >> gtTest [
	<profile: #test>
	^ TKTProfile
		on:
			{(#debugging -> false).
			(#runner -> TKTCommonQueueWorkerPool createDefault).
			(#poolWorkerProcess -> BlTKTWorkerProcess).
			(#process -> Process).
			(#errorHandler -> TKTExceptionHandler).
			(#processProvider -> TKTTaskItProcessProvider new).
			(#serviceManager -> TKTServiceManager new)} asDictionary
]
