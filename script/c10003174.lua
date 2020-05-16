--Megaria, the Collector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,0,2))
end
