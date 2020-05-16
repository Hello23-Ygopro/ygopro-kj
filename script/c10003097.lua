--Voidwing
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
