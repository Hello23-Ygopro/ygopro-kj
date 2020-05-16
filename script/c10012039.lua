--The Mystic of Fire
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,scard.brfilter,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1,1,c))
end
--break
scard.brfilter=aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_FIRE)
