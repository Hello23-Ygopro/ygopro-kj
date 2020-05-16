--Queen Sargasso
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DecktopConfirmOperation(PLAYER_OPPO,1))
end
