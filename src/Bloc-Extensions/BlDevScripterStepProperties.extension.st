Extension { #name : #BlDevScripterStepProperties }

{ #category : #'*Bloc-Extensions' }
BlDevScripterStepProperties >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties 
		detect: [ :eachProperty | eachProperty isScreenshot ]
		ifFound: [ :aScreenshot | aScreenshot gtScreenshotFor: aView ]
		ifNone: [ aView empty ]
]
