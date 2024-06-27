Extension { #name : #BlMouseProcessor }

{ #category : #'*BookletGraphicsBloc' }
BlMouseProcessor >> fireAsDragEndEvent: anEvent [
	| aDragEvent |
	
	aDragEvent := BlDragEndEvent new
		copyFrom: anEvent;
		yourself.
	
	self fireEvent:
			(aDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself).
	
	aDragEvent isConsumed
		ifFalse: [ self space dispatchEvent: (BlSpaceDragDropEvent new position: aDragEvent position) ]
]

{ #category : #'*BookletGraphicsBloc' }
BlMouseProcessor >> fireAsDropEvent: anEvent [
	| aDropEvent |

	aDropEvent := BlDropEvent new
		copyFrom: anEvent;
		yourself.
		
	self fireEvent: (aDropEvent
		gestureSource: currentDragTarget;
		gestureTarget: anEvent target;
		startButtons: dragStartMask;
		dragboard: self space dragboard;
		target: anEvent target;
		yourself)
]
