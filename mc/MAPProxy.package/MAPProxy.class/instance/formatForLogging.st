logging
formatForLogging

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: self class printString;
			  nextPut: $(;
			  nextPutAll: self class NodeName , ' Number=';
			  nextPutAll: (self localSCCPAddress ifNil: [ 'nil' ]);
			  nextPut: $) ]