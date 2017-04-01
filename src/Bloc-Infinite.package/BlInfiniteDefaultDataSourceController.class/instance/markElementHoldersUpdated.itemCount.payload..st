manager -> element
markElementHoldersUpdated: aPositionStart itemCount: anItemCount payload: aPayloadObject

	infiniteElement
		elementRangeUpdate: aPositionStart
		itemCount: anItemCount
		payload: aPayloadObject.
		
	infiniteElement markItemsChanged