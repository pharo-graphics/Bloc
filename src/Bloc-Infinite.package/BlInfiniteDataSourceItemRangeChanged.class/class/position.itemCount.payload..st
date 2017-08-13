instance creation
position: aPosition itemCount: anItemCount payload: anObject

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		payload: anObject;
		yourself