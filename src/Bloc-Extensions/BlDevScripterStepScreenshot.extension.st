Extension { #name : #BlDevScripterStepScreenshot }

{ #category : #'*Bloc-Extensions' }
BlDevScripterStepScreenshot >> gtScreenshotFor: aView [
	<gtView>
	self form ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Screenshot';
		stencil: [ self form asElement asScalableElement ]
]
