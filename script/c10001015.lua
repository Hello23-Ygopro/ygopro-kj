--Fumes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
