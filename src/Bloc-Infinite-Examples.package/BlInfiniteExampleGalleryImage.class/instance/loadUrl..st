accessing
loadUrl: anExtent
	^ 'https://unsplash.it/', (anExtent x min: 4096) asString, '/', (anExtent y min: 4096) asString,'?image=', self id asString