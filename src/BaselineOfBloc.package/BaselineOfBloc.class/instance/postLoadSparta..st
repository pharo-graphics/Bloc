actions
postLoadSparta: aSpecLoader
	"Let sparta load as it wish"
	
	Metacello new
		baseline: aSpecLoader spec name;
		repository: aSpecLoader spec repositories map keys first;
		load: self group