--Wildfire Valkyrie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--return
	aux.EnableTurnEndSelfReturn(c)
end
