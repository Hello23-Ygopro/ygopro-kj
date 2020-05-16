--Ramis the Cloaked
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
