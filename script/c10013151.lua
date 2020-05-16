--Sky Shark
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--get ability (ignore guard)
	aux.EnableEffectCustom(c,EFFECT_IGNORE_GUARD,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_GUARD))
	--get ability (ignore skirmisher)
	aux.EnableEffectCustom(c,EFFECT_IGNORE_SKIRMISHER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_GUARD))
end
