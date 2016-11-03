as yet unclassified
updateNextImageOn: aSpace
	
	imgIndex := (imgIndex % images size) + 1.
	aSpace updateCursorImage: (images at: imgIndex).