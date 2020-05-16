--Glu-urrgle 2.0
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_LORD))
	--blocker
	aux.EnableBlocker(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,scard.thfilter,4,0,4,SEQ_DECK_BOTTOM,nil,true))
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsCreature() and c:IsNameCategory(NAMECAT_GLUURRGLE)
end
