--Featherfin Stalker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TRENCH_HUNTER,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
