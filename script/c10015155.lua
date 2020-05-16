--Abyssal Scavenger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TRENCH_HUNTER,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
end
