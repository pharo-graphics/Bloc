event processing
processPicking: aTouchEvent
	<return: #BlElement>
	| aTargetElement |

	aTargetElement := self space root findMouseEventTargetAt: aTouchEvent position.
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement