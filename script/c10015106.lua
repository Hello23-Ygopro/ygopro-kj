--Lava Racer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--banish
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,aux.SelfBanishOperation)
end
