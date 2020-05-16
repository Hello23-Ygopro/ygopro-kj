--Flamespitter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_UNDERTOW_ENGINE,RACE_BURN_BELLY)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
