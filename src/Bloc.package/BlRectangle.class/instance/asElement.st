as yet unclassified
asElement
	^ super asElement 
		border: (BlBorder stroke: (BlBorder empty stroke copyWithRadius: self cornerRadius))