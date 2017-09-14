instance creation
fromRgbTripletOnBase256: array
	^ self r: (array first / 255) g: (array second / 255) b: (array last / 255)