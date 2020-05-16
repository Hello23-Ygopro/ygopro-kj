--Baron Burnfingers
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_SELF,1,1,c))
end
