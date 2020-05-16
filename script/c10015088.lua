--Vicious Coffer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MIMIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--to discard pile
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopKJSendtoDPileOperation(PLAYER_SELF,3))
end
