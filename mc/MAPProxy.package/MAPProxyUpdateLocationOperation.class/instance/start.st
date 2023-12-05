as yet unclassified
start
	| operationName invocation parameter operation |
	operationName := 'updateLocation'.
	operation := dialogue rosOperationNamed: operationName.
	parameter := operation newArgumentValue
		at: 'imsi' put: imsi toTBCD;
		at: 'vlr-Number' put: vlrNumber toE164;
		at: 'msc-Number' put: mscNumber toE164;
		yourself.
	dialogue
		onPAbort: [self failure];
		onUAbort: [self failure];
		onInvoke: [:isd |
			self extractMSISDN: isd argument.
			isd invocation returnResultLast: nil.
			dialogue requestTcContinue].
	invocation := dialogue requestTcInvoke: operation parameters:  parameter class: 1 timeout: 60.
	invocation
		onReturn: [self failure];
		onError: [self failure];
		onReject: [self failure];
		onLCancel: [[self failure] ensure: [ dialogue terminate]];
		onReturnLast: [:result | self successWith: [result]].
	dialogue
		requestTcBeginDestinationAddress: calledSCCPAddress
		originatingAddress: callingSCCPAddress
		applicationContextName: (dialogue applicationContextOidForOperationNamed: operationName).