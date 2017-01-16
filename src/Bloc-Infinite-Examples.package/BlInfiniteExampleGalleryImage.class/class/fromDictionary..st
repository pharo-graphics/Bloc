instance creation
fromDictionary: aDictionary
	^ self new
		format: (aDictionary at: #format);
		filename: (aDictionary at: #filename);
		author: (aDictionary at: #author);
		authorUrl: (aDictionary at: #author_url);
		height: (aDictionary at: #height);
		postUrl: (aDictionary at: #post_url);
		id: (aDictionary at: #id);
		width: (aDictionary at: #width);
		yourself