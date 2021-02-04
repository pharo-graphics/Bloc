Extension { #name : #Error }

{ #category : #'*Bloc-Scripter' }
Error >> passWithScripter: aScripter [
	BlDevScripterError new
		scripter: aScripter;
		exception: self;
		messageText: self messageText;
		signal
]
