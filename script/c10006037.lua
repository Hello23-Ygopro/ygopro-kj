--Burnclaw the Relentless
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DRAKON))
	--search (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_DECK,0,0,1))
end
--search (to battle)
function scard.tbfilter(c)
	return c:IsCode(sid)
end
