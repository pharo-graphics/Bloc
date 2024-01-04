Extension { #name : #AssertionFailure }

{ #category : #'*Bloc-Scripter' }
AssertionFailure >> passWithScripter: aScripter [
	BlDevScripterAssertionFailure new
		scripter: aScripter;
		exception: self;
		messageText: self messageText;
		signal
]
