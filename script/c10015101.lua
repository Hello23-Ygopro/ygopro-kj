--Igniss
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--search (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_DECK,0,0,1))
end
--search (to battle)
function scard.tbfilter(c)
	return c:IsCreature() and c:IsNameCategory(NAMECAT_VALKO)
end
