--Spelljacker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cast for free
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.CastOperation(PLAYER_SELF,aux.KJDPileFilter(),0,LOCATION_DPILE,1))
end
