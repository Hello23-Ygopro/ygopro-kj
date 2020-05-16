--Aqua Seneschal (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
