-module(savexct).

-export([compile/0]).

compile() ->
    asn1ct:compile("MSDASN1Module", [uper]),
    asn1ct:compile("ERAOADASN1Module", [uper]),
    asn1ct:compile("SaveXCommon", [uper]),
    asn1ct:compile("SaveXMSD", [uper]).
