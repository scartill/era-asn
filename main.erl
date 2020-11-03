-module(main).

-include("MSDASN1Module.hrl").
-include("ERAOADASN1Module.hrl").

-export([run/0]).

era_oid() ->
    "1.4.2".

aux_record() ->
    #'ERAAdditionalData' {
        crashSeverityASI15 = 1024,
        diagnosticResult = #'DiagnosticResult' {
            micConnectionFailure = true,
            micFailure = true,
            rightSpeakerFailure = true,
            leftSpeakerFailure = true,
            speakersFailure = true,
            ignitionLineFailure = true,
            uimFailure = true,
            statusIndicatorFailure = true,
            batteryFailure = true,
            batteryVoltageLow = true,
            crashSensorFailure = true,
            firmwareImageCorruption = true,
            commModulelnterfaceFailure = true,
            gnssReceiverFailure = true,
            raimProblem = true,
            gnssAntennaFailure = true,
            commModuleFailure = true,
            eventsMemoryOverflow = true,
            crashProfileMemoryOverflow = true,
            otherCriticalFailures = true,
            otherNotCriticalFailures = true
        },
        crashInfo = #'CrashInfo' {
            crashFront = true,
            crashLeft = true,
            crashRight = true,
            crashRear = true,
            crashRollover = true,
            crashSide = true,
            crashFrontOrSide = true,
            crashAnotherType = true
        },
        coordinateSystemType = pz90
    }.

full_record(AuxBin) ->
    #'ECallMessage' {
        id = 1,
        msd = #'MSDMessage' {
            msdStructure = #'MSDStructure' {
                messageIdentifier = 1,
                control = #'ControlType' {
                    automaticActivation = true,
                    testCall = true,
                    positionCanBeTrusted = true,
                    vehicleType = passengerVehicleClassM1
                },
                vehicleldentificationNumber = #'VIN' {
                    isowmi = "AAA",
                    isovds = "BBBBBB",
                    isovisModelyear = "C",
                    isovisSeqPlant = "DDDEEEE"
                },
                vehiclePropulsionStorageType = #'VehiclePropulsionStorageType' {
                      gasolineTankPresent = true
                },
                timestamp = 1604398343,
                vehicleLocation = #'VehicleLocation' {
                    positionLatitude = 0,
                    positionLongitude = 0
                },
                vehicleDirection = 90
            },
            optionalAdditionalData = #'AdditionalData' {
                oid = era_oid(),
                data = AuxBin
            }
        }
    }.

run() ->
    {ok, AuxBin} = 'ERAOADASN1Module':encode('ERAAdditionalData', aux_record()),
    {ok, Bin} = 'MSDASN1Module':encode('ECallMessage', full_record(AuxBin)),
    byte_size(Bin).
