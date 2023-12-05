as yet unclassified
updateLocation: aRequest for: aDelegate

	| imsi gt op |
	imsi := aRequest mobileIdentity fromTBCD.
	logger
		logDebug: 'sendAuthentication failed'
		with: { ('imsi' -> imsi) }.

	gt := self gtForIMSI: imsi.
	op := MAPProxyUpdateLocationOperation new.
	op
		dialogue: self newDialogue;
		callingSCCPAddress: (self callingSCCPAddress: gt callingSSN);
		calledSCCPAddress: (self calledSCCPAddress: (gt prepare: imsi));
		imsi: imsi;
		mscNumber: mscNumber;
		vlrNumber: vlrNumber;
		onFailure: [ 
			self returnUpdateLocationFailureFor: aRequest on: aDelegate ];
		onSuccess: [ :result | 
			self
				returnUpdateLocationResultFor: aRequest
				with: op
				on: aDelegate
				result: result ];
		start