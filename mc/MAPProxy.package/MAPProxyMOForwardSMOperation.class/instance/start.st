as yet unclassified
start
	| operationName invocation parameter operation |
	operationName := 'mo-ForwardSM'.
	operation := dialogue rosOperationNamed: operationName.
	parameter := operation newArgumentValue.
	(parameter expandFieldNamed: 'sm-RP-DA')
			at: 'imsi' put: imsi toTBCD.
	(parameter expandFieldNamed: 'sm-RP-OA') 
			at: 'serviceCentreAddressOA' put: '447802000630' toE164.
	parameter at: 'sm-RP-UI' put: (ByteArray readHexFrom: '4405a19572f27ff6322160715103403d027000003815163910100000015eade1e44f20cfadcfbbfcfec782d30bc3231e51d6f4ced7340f82f0257d0ca69a992a559ce761f18d0b6b2343c463fe').
	dialogue
		onPAbort: [self failure];
		onUAbort: [self failure];
		onInvoke: [:isd |
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